import yaml
import os

from django.conf import settings


class ScriptConfig:
    config_path = os.path.join(settings.BASE_DIR, "process_launcher", "config_files", "conf.yaml")

    def __init__(self):
        self.config = self._parse_yaml_config()

    def _parse_yaml_config(self):
        with open(self.config_path, 'r') as stream:
            try:
                config = yaml.safe_load(stream)
            except yaml.YAMLError as exc:
                print(exc)
            return config

    def get_script_names(self):
        return [script for script in self.config["script_configs"]]

    def get_script_choices(self):
        return [(script, script) for script in self.config["script_configs"]]

    def get_args_of_script(self, script):
        return self.config["script_configs"][script]["args"]
