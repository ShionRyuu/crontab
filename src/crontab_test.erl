%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% @doc Test support code
%%% @copyright Bjorn Jensen-Urstad 2012
%%% @end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Module declaration ===============================================
-module(crontab_test).

%% Exports ==========================================================
-export([
    execute_funs/1, 
    with_crontab/1, 
    waitfor/1
]).

%% Code =============================================================
%% API -------------------------------------------------------------
execute_funs(Fs) ->
    lists:foreach(fun(F) -> F() end, Fs).

with_crontab(F) ->
    try
        start_app(crontab),
        F()
    after
        stop_app(crontab)
    end.

waitfor(App) ->
    case whereis(App) of
        undefined -> ok;
        _Pid -> timer:sleep(1), waitfor(App)
    end.

%% Internals -------------------------------------------------------
start_app(App) ->
    ok = application:start(App).

stop_app(App) ->
    ok = application:stop(App),
    waitfor(App).

%% Tests ============================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

-else.
-endif.
