require 'prometheus/client'

$prometheus = Prometheus::Client.registry

total_requests_from_main_direct_app = Prometheus::Client::Counter.new(
 :total_requests_from_main_direct_app,
 'Total number of requests from MainDirectAPP'
)
$prometheus.register(total_requests_from_main_direct_app)

total_requests_from_proxy_app = Prometheus::Client::Counter.new(
 :total_requests_from_proxy_app,
 'Total number of requests from ProxyAPP'
)
$prometheus.register(total_requests_from_proxy_app)

total_requests_from_unauthorized_app = Prometheus::Client::Counter.new(
 :total_requests_from_unauthorized_app,
 'Total number of requests from Unauthorized'
)
$prometheus.register(total_requests_from_unauthorized_app)
