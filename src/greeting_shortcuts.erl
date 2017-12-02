%%%-------------------------------------------------------------------
%%% @author ratopi
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Dez 2017 17:09
%%%-------------------------------------------------------------------
-module(greeting_shortcuts).
-author("ratopi").

%% API
-compile(export_all).


render_ok(Req, TemplateModule, Params) ->
	render_ok(Req, [], TemplateModule, Params).


render_ok(Req, Headers, TemplateModule, Params) ->
	{ok, Output} = TemplateModule:render(Params),
	Req:ok({"text/html", Headers, Output}).


get_cookie_value(Req, Key, Default) ->
	case Req:get_cookie_value(Key) of
		undefined -> Default;
		Value -> Value
	end.
