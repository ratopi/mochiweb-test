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
	{ok, Output} = TemplateModule:render(Params),
	% Here we use mochiweb_request:ok/1 to render a reponse
	Req:ok({"text/html", Output}).
