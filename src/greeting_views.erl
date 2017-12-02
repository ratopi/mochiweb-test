%%%-------------------------------------------------------------------
%%% @author ratopi
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Dez 2017 16:59
%%%-------------------------------------------------------------------
-module(greeting_views).
-author("ratopi").

%% API
-compile(export_all).

-import(greeting_shortcuts, [render_ok/3]).

urls() -> [
	{"^hello/?$", hello},
	{"^hello/(.+?)/?$", hello}
].


hello('GET', Req) ->
	QueryStringData = Req:parse_qs(),
	Username = proplists:get_value("username", QueryStringData, "Anonymous"),
	render_ok(Req, greeting_dtl, [{username, Username}]);

hello('POST', Req) ->
	PostData = Req:parse_post(),
	Username = proplists:get_value("username", PostData, "Anonymous"),
	render_ok(Req, greeting_dtl, [{username, Username}]).


hello('GET', Req, Username) ->
	render_ok(Req, greeting_dtl, [{username, Username}]);

hello('POST', Req, _) ->
	% Ignore URL parameter if it's a POST
	hello('POST', Req).
