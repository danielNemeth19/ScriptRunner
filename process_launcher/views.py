import json
from django.http import HttpResponse, HttpResponseRedirect
from django.views.generic import TemplateView
from django.shortcuts import render
from django.urls import reverse
from process_launcher.forms import ScriptSelectFrom, ScriptArgsForm
from process_launcher.script_handler import ScriptConfig


class HomeProcessLauncher(TemplateView):
    template_name = "process_launcher/pl_base.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["script_select_form"] = ScriptSelectFrom()
        return context


def script_request_handler(request):
    if request.method == "GET":
        print(request)
        form = ScriptSelectFrom(request.GET)
        if form.is_valid():
            selected_script = form.cleaned_data['processes']
            config = ScriptConfig()
            script_args = config.get_args_of_script(selected_script)
            script_args_form = ScriptArgsForm(field_data=script_args)
            return render(request, "process_launcher/pl_base.html", context={"script_args_form": script_args_form})
    elif request.method == "POST":
        return HttpResponse(json.dumps("post data"), content_type="application/json")
