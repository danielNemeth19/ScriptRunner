from django.contrib import admin
from django.conf.urls import include
from django.urls import path
from ScriptRunner import views


urlpatterns = [
    path('admin/', admin.site.urls),
    path('index/', views.Home.as_view(), name="script_runner_home"),
    path('process_launcher/', include('process_launcher.urls'), name='process_launcher')

]
