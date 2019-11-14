<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=Generator content="Microsoft Word 15 (filtered)">

</head>

<body lang=EN-US>

<div class=WordSection1>

<p class=MsoNormal>Epilogue </p>

<p class=MsoNormal>A Cognitive Distributed AI Virtual Machine for the
Processing and Understanding of Data</p>

<p class=MsoNormal>Epilogue is an experiment in the creation of a distributed
data and analytics appliance specifically for processing large geo-distributed
data sets that are a hybrid of denormalized relational, network, graph and document
(unstructured).</p>

<p class=MsoNormal>The system has at its basis the following technologies (in a
somewhat tailored form)</p>

<p class=MsoListParagraphCxSpFirst style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>A stripped-down embedded Linux kernel</p>

<p class=MsoListParagraphCxSpMiddle style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>A highly customized Erlang/OTP implementation (a domain specific
alteration of BEAM)</p>

<p class=MsoListParagraphCxSpMiddle style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>An extended Prolog implementation (tightly integrated with BEAM and
the Linux Kernel</p>

<p class=MsoListParagraphCxSpLast style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>A minimized embedded TCL implementation (tightly integrated with BEAM)
</p>

<p class=MsoNormal>On top of this infrastructure analytics capabilities are
built that span a large virtual memory and storage space that enforce data
rules around (GDPR, and other governance and restriction requirements).</p>

<p class=MsoNormal>Epilogue should not be viewed as a data store but as a vault
implementation of an object store where objects have intelligence relative to
how they live within the environment (e.g. Objects are responsible for access, location,
promotion, integrity, and evolution).</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>Immediate Work:</p>

<p class=MsoListParagraphCxSpFirst style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>Mapping out the virtual architecture</p>

<p class=MsoListParagraphCxSpMiddle style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>Breaking out Linux services and mapping into BEAM (Erlang/Beam
being the sole access to OS services).</p>

<p class=MsoListParagraphCxSpLast style='text-indent:-.25in'><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>Refactoring BEAM to work in this specific architecture with
little to no other environment consideration where there would be any
performance trade off.</p>

<p class=MsoNormal>See the documents directory for more information as the
product progresses.</p>

<p class=MsoListParagraph>&nbsp;</p>

</div>

</body>

</html>
