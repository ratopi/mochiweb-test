%% Based on template of Mochi Media <dev@mochimedia.com>
%% @author Ralf Th. Pietsch <ratopi@abwesend.de>
%% @copyright 2017 Ralf Th. Pietsch <ratopi@abwesend.de>

%% @doc Web server for greeting.

-module(greeting_web).
-author("Ralf Th. Pietsch <ratopi@abwesend.de>").

-export([start/1, stop/0, loop/2]).

%% External API

start(Options) ->
	{DocRoot, Options1} = get_option(docroot, Options),
	Loop =
		fun(Req) ->
			?MODULE:loop(Req, DocRoot)
		end,
	mochiweb_http:start([{name, ?MODULE}, {loop, Loop} | Options1]).

stop() ->
	mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
		"/" ++ Path = Req:get(path),
	try
		case Req:get(method) of
			Method when Method =:= 'GET'; Method =:= 'HEAD' ->

				case Path of

					"hello_world" ->
						Req:respond({200, [{"Content-Type", "text/plain"}], "Hello world!\n"});

					"hello" ->
						QueryStringData = Req:parse_qs(),
						Username = proplists:get_value("username", QueryStringData, "unknown"),
						Req:respond({200, [{"Content-Type", "text/plain"}], "Hello " ++ Username ++ "!\n"});

					"helloT" ->
						QueryStringData = Req:parse_qs(),
						Username = proplists:get_value("username", QueryStringData, "unknown"),
						{ok, HTMLOutput} = greeting_dtl:render([{username, Username}]),
						Req:respond({200, [{"Content-Type", "text/html"}], HTMLOutput});

					_ ->
						Req:serve_file(Path, DocRoot)

				end;

			'POST' ->

				case Path of
					_ ->
						Req:not_found()
				end;

			_ ->
				Req:respond({501, [], []})

		end

	catch
		Type:What ->
			Report = [
				"web request failed",
				{path, Path},
				{type, Type},
				{what, What},
				{trace, erlang:get_stacktrace()}
			],
			error_logger:error_report(Report),
			Req:respond({500, [{"Content-Type", "text/plain"}], "request failed, sorry\n"})
	end.

%% Internal API

get_option(Option, Options) ->
	{proplists:get_value(Option, Options), proplists:delete(Option, Options)}.

%%
%% Tests
%%
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

you_should_write_a_test() ->
	?assertEqual(
		"No, but I will!",
		"Have you written any tests?"),
	ok.

-endif.
