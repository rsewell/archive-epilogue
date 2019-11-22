#!/usr/bin/env perl
# -*- cperl -*-

# %CopyrightBegin%
# 
# Copyright Ericsson AB 2003-2016. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
# %CopyrightEnd%

print STDOUT "THIS IS A TEST !!!!!! $ARGC, $ARGV[0], $ARGV[1], $ARGV[2], $ARGV[3], $ARGV[4], $ARGV[5]\n";

use strict;
# use warnings;

use File::Basename;

#
# Description:
#   Generates a header file containing defines for memory allocation types
#   from type declarations in a config file.
#
# Usage:
#    make_alloc_types -src <config-file> -dst <c-header-file>
#
# Options:
#    -src <config-file>
#    -dst <c-header-file>
#    [<enabled-boolean-variable> ...]
#
# Author: Rickard Green
#

my $myname = basename($0);
my $src;
my $dst;
my %bool_vars;

while (@ARGV && $ARGV[0]) {
    my $opt = shift;
    if ($opt eq '-src') {
        $src = shift;
        $src or die "$myname: Missing source file\n";
    } elsif ($opt eq '-dst') {
        $dst = shift;
        $dst or die "$myname: Missing destination file\n";
    } else {
        $bool_vars{$opt} = 'true';
    }
}

$src or usage("Missing source file");
$dst or usage("Missing destination file");

open(SRC, "<$src") or die "$myname: Failed to open $src in read mode\n";

my $line;
my $line_no = 0;
my $decl;

my %a_tab;
my %c_tab;
my %t_tab;
my %d_tab;
my @a_order;
my @c_order;
my @t_order;

my @cond_stack;

#############################################################################
# Parse source file
#############################################################################

while ($line = <SRC>) {
   $line_no = $line_no + 1;
   $line = preprocess_line($line);


   print STDOUT "$line_no: $line \n";

    if ($line =~ /^(\S+)\s*(.*)/) {
        $decl = $1;
        $line = $2;

        if ($decl eq 'type') {
            if ($line =~ /^(\w+)\s+(\w+)\s+(\w+)\s+(\w+)\s*$/) {
                 my $t = $1;
                 my $a = $2;
                 my $c = $3;
                 my $d = $4;

                 check_reserved_words('type', $t, $d);

                 my $a_entry = $a_tab{$a};
                 $a_entry or src_error("No allocator '$a' declared");
                 my $c_entry = $c_tab{$c};
                 $c_entry or src_error("No class '$c' declared");

                !$t_tab{$t} or src_error("Type '$t' already declared");
                my $d_user = $d_tab{$d};
                !$d_user or duplicate_descr($d, $d_user);

                $t_tab{$t} = mk_entry($d, $a, $c);
                add_type($a_entry, $t);

                $d_tab{$d} = "type '$t'";

            } else {
                invalid_decl($decl);
            }
        } elsif ($decl eq 'allocator') {
            if ($line =~ /^(\w+)\s+(\w+)\s+(\w+)\s*$/) {
                my $a = $1;
                my $mt = $2;
                my $d = $3;

                check_reserved_words('allocator', $a, $d);

                !$a_tab{$a} or src_error("Allocator '$a' already declared");
                my $d_user = $d_tab{$d};
                !$d_user or duplicate_descr($d, $d_user);

                my $e = mk_entry($d);
                $a_tab{$a} = $e;

                if ($mt =~ /^true$/) {
                    set_multi_thread($e);
                }
                else {
                    $mt =~ /^false$/ or src_error("Multi-thread option not a boolean");
                }
                $d_tab{$d} = "allocator '$a'";

                push(@a_order, $a);

            } else {
                invalid_decl($decl);
            }
       } elsif ($decl eq 'class') {
           if ($line =~ /^(\w+)\s+(\w+)\s*$/) {
               my $c = $1;
               my $d = $2;

               check_reserved_words('class', $c, $d);

               !$c_tab{$c} or src_error("Class '$c' already declared");
               my $d_user = $d_tab{$d};
               !$d_user or duplicate_descr($d, $d_user);

               $c_tab{$c} = mk_entry($d);

               $d_tab{$d} = "class '$c'";

           } else {
               invalid_decl($decl);
           }
       } else {
           src_error("Unknown '$decl' declaration found");
       }
    }
}

close(SRC) or warn "$myname: Error closing $src";

check_cond_stack();

#############################################################################
# Create destination file
#############################################################################

mkdir(dirname($dst), 0777);
open(DST, ">$dst") or die "$myname: Failed to open $dst in write mode\n";

print DST "/*
 * -----------------------------------------------------------------------
 *
 * NOTE: Do *not* edit this file; instead, edit '", basename($src),"' and
 *       build again! This file was automatically generated by
 *       '$myname' on ", (scalar localtime), ".
 *
 * -----------------------------------------------------------------------
 *
 * 
 * Copyright Ericsson AB ", (1900 + (localtime)[5]), ". All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the \"License\");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an \"AS IS\" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 */

#ifndef ERL_ALLOC_TYPES_H__
#define ERL_ALLOC_TYPES_H__

";

my $a_no = 1;
my $c_no = 1;
my $t_no = 1;

# Print allocator numbers -------------------------------------------------

print DST "
/* --- Allocator numbers -------------------------------------------------- */

#define ERTS_ALC_A_INVALID (0)

";

print DST "#define ERTS_ALC_A_MIN ($a_no)\n\n";

foreach my $a (@a_order) {
  set_number($a_tab{$a}, $a_no);
  print DST "#define ERTS_ALC_A_$a ($a_no)\n";
  $a_no++;
}
$a_no--;

print DST "\n#define ERTS_ALC_A_MAX ($a_no)\n";

# Print class numbers -----------------------------------------------------

print DST "

/* --- Class numbers ------------------------------------------------------ */

#define ERTS_ALC_C_INVALID (0)

";

print DST "#define ERTS_ALC_C_MIN ($c_no)\n\n";

foreach my $c (sort keys(%c_tab)) {
  push(@c_order, $c);
  set_number($c_tab{$c}, $c_no);
  print DST "#define ERTS_ALC_C_$c  ($c_no)\n";
  $c_no++;
}
$c_no--;
print DST "\n#define ERTS_ALC_C_MAX ($c_no)\n";

# Print type number intervals ---------------------------------------------

print DST "

/* --- Type number intervals ---------------------------------------------- */

#define ERTS_ALC_N_INVALID (0)

";

print DST "#define ERTS_ALC_N_MIN ($t_no)\n\n";

foreach my $a (@a_order) {
  my $a_entry = $a_tab{$a};
  my $ts = get_types($a_entry);
  my $n_ts = @{$ts};
  if ($n_ts > 0) {

    print DST "/* Type numbers used for ", get_description($a_entry), " */\n";
    print DST "#define ERTS_ALC_N_MIN_A_$a ($t_no)\n";

    foreach my $t (@{$ts}) {
      push(@t_order, $t);
      set_number($t_tab{$t}, $t_no);
#      print DST "#define ERTS_ALC_N_$t ($t_no)\n";
      $t_no++;
    }

    print DST "#define ERTS_ALC_N_MAX_A_$a (", $t_no - 1, ")\n\n";
  }
  else {
    print DST "/* No types use ", get_description($a_entry), " */\n\n";
  }
}
$t_no--;
print DST "#define ERTS_ALC_N_MAX ($t_no)\n";

# Print multi thread use of allocators -------------------------------------

print DST "

/* --- Multi thread use of allocators -------------------------------------- */

";

foreach my $a (@a_order) {
  my $mt = get_multi_thread($a_tab{$a});
  print DST "#define ERTS_ALC_MTA_$a (", $mt ? "1" : "0" ,")\n";
}


# Calculate field sizes, masks, and shifts needed --------------------------

my $a_bits = fits_in_bits($a_no);
my $c_bits = fits_in_bits($c_no);
my $n_bits = fits_in_bits($t_no);
my $t_bits = $a_bits + $n_bits + $c_bits;

$n_bits <= 16
  # Memory trace format expects type numbers to fit into an Uint16
  or die("$myname: ", $t_no + 1, " types declared;",
	 " maximum number of types allowed are ", (1 << 16),"\n");

$t_bits <= 24
  # We want 8 bits for flags (we actually only use 1 bit for flags
  # at the time of writing)...
  or die("$myname: More allocators, classes, and types declared than ",
	 "allowed\n");

my $a_mask = (1 << $a_bits) - 1;
my $c_mask = (1 << $c_bits) - 1;
my $n_mask = (1 << $n_bits) - 1;
my $t_mask = (1 << $t_bits) - 1;

my $a_shift = 0;
my $c_shift = $a_bits + $a_shift;
my $n_shift = $c_bits + $c_shift;


# Print the types ----------------------------------------------------------

print DST "

/* --- Types --------------------------------------------------------------- */

typedef Uint32 ErtsAlcType_t; /* The type used for memory types */

#define ERTS_ALC_T_INVALID (0)

";

foreach my $t (@t_order) {
  print DST
    "#define ERTS_ALC_T_$t (",
      ((get_number($a_tab{get_allocator($t_tab{$t})}) << $a_shift)
       | (get_number($c_tab{get_class($t_tab{$t})}) << $c_shift)
       | (get_number($t_tab{$t}) << $n_shift)),
	 ")\n";
}



# Print field sizes, masks, and shifts needed ------------------------------

print DST "

/* --- Field sizes, masks, and shifts -------------------------------------- */

#define ERTS_ALC_A_BITS ($a_bits)
#define ERTS_ALC_C_BITS ($c_bits)
#define ERTS_ALC_N_BITS ($n_bits)
#define ERTS_ALC_T_BITS ($t_bits)

#define ERTS_ALC_A_MASK ($a_mask)
#define ERTS_ALC_C_MASK ($c_mask)
#define ERTS_ALC_N_MASK ($n_mask)
#define ERTS_ALC_T_MASK ($t_mask)

#define ERTS_ALC_A_SHIFT ($a_shift)
#define ERTS_ALC_C_SHIFT ($c_shift)
#define ERTS_ALC_N_SHIFT ($n_shift)
";

# Print mappings needed ----------------------------------------------------

print DST "

/* --- Mappings ------------------------------------------------------------ */

/* type -> type number */
#define ERTS_ALC_T2N(T) (((T) >> ERTS_ALC_N_SHIFT) & ERTS_ALC_N_MASK)

/* type -> allocator number */
#define ERTS_ALC_T2A(T) (((T) >> ERTS_ALC_A_SHIFT) & ERTS_ALC_A_MASK)

/* type -> class number */
#define ERTS_ALC_T2C(T) (((T) >> ERTS_ALC_C_SHIFT) & ERTS_ALC_C_MASK)

/* type number -> type */
#define ERTS_ALC_N2T(N) (erts_alc_n2t[(N)])

/* type number -> type description */
#define ERTS_ALC_N2TD(N) (erts_alc_n2td[(N)])

/* type -> type description */
#define ERTS_ALC_T2TD(T) (ERTS_ALC_N2TD(ERTS_ALC_T2N((T))))

/* class number -> class description */
#define ERTS_ALC_C2CD(C) (erts_alc_c2cd[(C)])

/* allocator number -> allocator description */
#define ERTS_ALC_A2AD(A) (erts_alc_a2ad[(A)])

extern const ErtsAlcType_t erts_alc_n2t[];
extern const char *erts_alc_n2td[];
extern const char *erts_alc_c2cd[];
extern const char *erts_alc_a2ad[];

#ifdef ERTS_ALC_INTERNAL__

const ErtsAlcType_t erts_alc_n2t[] = {
  ERTS_ALC_T_INVALID,
";

foreach my $t (@t_order) {
  print DST "  ERTS_ALC_T_$t,\n";
}

print DST "  ERTS_ALC_T_INVALID
};

const char *erts_alc_n2td[] = {
  \"invalid_type\",
";

foreach my $t (@t_order) {
  print DST "  \"", get_description($t_tab{$t}), "\",\n";
}

print DST "  NULL
};

const char *erts_alc_c2cd[] = {
  \"invalid_class\",
";

foreach my $c (@c_order) {
  print DST "  \"", get_description($c_tab{$c}), "\",\n";
}

print DST "  NULL
};

const char *erts_alc_a2ad[] = {
  \"invalid_allocator\",
";

foreach my $a (@a_order) {
  print DST "  \"", get_description($a_tab{$a}), "\",\n";
}

print DST "  NULL
};
";

print DST "
#endif /* #ifdef ERTS_ALC_INTERNAL__ */
";

# End of DST
print DST "

/* ------------------------------------------------------------------------- */
#endif /* #ifndef ERL_ALLOC_TYPES_H__ */
";


close(DST) or warn "$myname: Error closing $dst";

exit;

#############################################################################
# Help routines
#############################################################################

sub fits_in_bits {
  my $val = shift;
  my $bits;

  $val >= 0 or die "Expected value >= 0; got $val";

  $bits = 0;

  while ($val != 0) {
    $val >>= 1;
    $bits++;
  }

  return $bits;
}

#############################################################################
# Table entries
#

sub mk_entry {
  my $d = shift;
  my $a = shift;
  my $c = shift;
  return [$d, undef, [], $a, $c, undef];
}

sub get_description {
  my $entry = shift;
  return $entry->[0];
}

sub get_number {
  my $entry = shift;
  return $entry->[1];
}

sub get_types {
  my $entry = shift;
  return $entry->[2];
}

sub get_allocator {
  my $entry = shift;
  return $entry->[3];
}

sub get_class {
  my $entry = shift;
  return $entry->[4];
}

sub set_number {
  my $entry = shift;
  my $number = shift;
  $entry->[1] = $number;
}

sub add_type {
  my $entry = shift;
  my $t = shift;
  push(@{$entry->[2]}, $t);
}

sub set_multi_thread {
  my $entry = shift;
  $entry->[5] ='true';
}

sub get_multi_thread {
  my $entry = shift;
  return $entry->[5];
}

#############################################################################
# Preprocessing of a line

sub preprocess_line {
  my $line = shift;
  $line =~ s/#.*$//;
  $line =~ /^\s*(.*)$/;
  $line = $1;

  if (!@cond_stack) {
      push(@cond_stack, [undef, undef, undef, 'true', undef]);
  }

  my $see_line = $cond_stack[@cond_stack - 1]->[3];

  if ($line =~ /^(\S+)(.*)$/) {
      my $ifdefop = $1;
      my $ifdefarg = $2;

      if ($ifdefop eq '+if') {
          $ifdefarg =~ /^\s*(\w+)\s*$/ or src_error("Bad '+if'");    
          my $var = $1;
          if ($see_line) {
              $see_line = $bool_vars{$var};
          }
          push(@cond_stack, ['+if', $var, undef, $see_line, $line_no]);
          $see_line = undef;
      }
      elsif ($ifdefop eq '+ifnot') {
          $ifdefarg =~ /^\s*(\w+)\s*$/ or src_error("Bad '+ifnot'");
          my $var = $1;
          if ($see_line) {
              $see_line = !$bool_vars{$var};
          }
          push(@cond_stack, ['+ifnot', $var, undef, $see_line, $line_no]);
          $see_line = undef;
      }
elsif ($ifdefop eq '+else') {
$ifdefarg =~ /^\s*$/ or src_error("Garbage after '+else'");
my $val = $cond_stack[@cond_stack - 1];
$val->[0] or src_error("'+else' not matching anything");
!$val->[2] or src_error("duplicate '+else'");
$val->[2] = 'else';
if ($see_line || $cond_stack[@cond_stack - 2]->[3]) {
$val->[3] = !$val->[3];
}
$see_line = undef;
}
elsif ($ifdefop eq '+endif') {
$ifdefarg =~ /^\s*$/ or src_error("Garbage after '+endif'");
my $val = pop(@cond_stack);
$val->[0] or src_error("'+endif' not matching anything");
$see_line = undef;
}
elsif ($see_line) {
if ($ifdefop eq '+enable') {
$ifdefarg =~ /^\s*(\w+)\s*$/ or src_error("Bad '+enable'");
$bool_vars{$1} = 'true';
$see_line = undef;
}
elsif ($ifdefop eq '+disable') {
$ifdefarg =~ /^\s*(\w+)\s*$/ or src_error("Bad '+disable'");
$bool_vars{$1} = undef;
$see_line = undef;
}
}
}

return $see_line ? $line : "";
}

sub check_cond_stack {
my $val = $cond_stack[@cond_stack - 1];
if ($val->[0]) {
$line_no = $val->[4];
src_error("'", $val->[0], " ", $val->[1], "' not terminated\n");
}
}

sub check_reserved_words {
my $sort = shift;
my $name = shift;
my $descr = shift;

!($name eq 'INVALID')
or src_error("Reserved $sort 'INVALID' declared");
!($descr eq 'invalid_allocator')
or src_error("Reserved description 'invalid_allocator' used");
!($descr eq 'invalid_class')
or src_error("Reserved description 'invalid_class' used");
!($descr eq 'invalid_type')
or src_error("Reserved description 'invalid_type' used");
}

#############################################################################
# Error cases

sub usage {
warn "$myname: ", @_, "\n";
die "Usage: $myname -src <source> -dst <destination> [<var> ...]\n";
}

sub src_error {
die "$src:$line_no: ", @_, "\n";
}

sub duplicate_descr {
my $d = shift;
my $u = shift;
src_error("Description '$d' already used for '$u'");
}

sub invalid_decl {
my $decl = shift;
src_error("Invalid '$decl' declaration");
}

#############################################################################
