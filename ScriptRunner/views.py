from django.views.generic import TemplateView


class Home(TemplateView):
    template_name = "ScriptRunner/index.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context
