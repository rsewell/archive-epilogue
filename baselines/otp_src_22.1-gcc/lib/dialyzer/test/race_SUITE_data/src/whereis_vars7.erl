%% This tests that warnings do appear when there is no specific
%% information about the types and the variables are bound.

-module(whereis_vars7).
-export([start/2]).

start(AnAtom, Fun) ->
  case whereis(AnAtom) of
    undefined ->
      Pid = spawn(Fun),
      OtherAtom = kostis,
      case Pid =:= self() of
        true -> ok;
        false ->
          case [AnAtom, Pid] of
            [OtherAtom, APid] -> register(OtherAtom, APid);
	    _Other -> ok
	  end
      end;
    P when is_pid(P) ->
      ok
  end.
