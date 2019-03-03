require 'prometheus/client'

$prometheus = Prometheus::Client.registry

total_requests_from_main_via_proxy_one_app = Prometheus::Client::Counter.new(
 :total_requests_from_main_via_proxy_one_app,
 'Total number of requests from MainViaProxyOneAPP'
)
$prometheus.register(total_requests_from_main_via_proxy_one_app)

total_requests_from_main_via_proxy_two_app = Prometheus::Client::Counter.new(
 :total_requests_from_main_via_proxy_two_app,
 'Total number of requests from MainViaProxyTwoAPP'
)
$prometheus.register(total_requests_from_main_via_proxy_two_app)

total_requests_from_unauthorized_app = Prometheus::Client::Counter.new(
 :total_requests_from_unauthorized_app,
 'Total number of requests from Unauthorized'
)
$prometheus.register(total_requests_from_unauthorized_app)
