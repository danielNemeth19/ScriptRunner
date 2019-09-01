from django.urls import path
from process_launcher import views

app_name = "process_launcher"

urlpatterns = [
    path('', views.HomeProcessLauncher.as_view(), name="pl_home_view"),
    path('script_params', views.script_request_handler, name="script_config")

]