# VCL version 5.0 is not supported so it should be 4.0 or 4.1 even though actually used Varnish version is 6
vcl 4.0;

import std;
# The minimal Varnish version is 5.0
# For SSL offloading, pass the following header in your proxy server or load balancer: 'X-Forwarded-Proto: https'

backend default {
  .host = "{{ default "google.com" .Values.varnishBackendService }}";
  .port = "{{ default "80" .Values.varnishBackendServicePort }}";
}
