from django import forms
from .script_handler import ScriptConfig


class ScriptSelectFrom(forms.Form):
    processes = forms.ChoiceField(widget=forms.Select, choices=ScriptConfig().get_script_choices())


class ScriptArgsForm(forms.Form):
    def __init__(self, *args, **kwargs):
        self.field_data = kwargs.pop("field_data")
        super().__init__(*args, **kwargs)

        for field in self.field_data:
            if field["type"] == "string":
                self.fields[field['name_to_show']] = forms.CharField(
                    max_length=100,
                    help_text="TBD",
                    required=True,
                    initial="default"
                )
            elif field["type"] == "date":
                self.fields[field['name_to_show']] = forms.DateField()
