FROM grafana/grafana:latest
COPY provisioning/ /etc/grafana/provisioning/
COPY dashboards/ /var/lib/grafana/dashboards/
EXPOSE 3000

# Makefile for easy deployment
.PHONY: monitoring-up monitoring-down monitoring-logs

monitoring-up:
	@echo "🚀 Starting NutriSolutions with Monitoring Stack..."
	docker-compose -f docker-compose.yml -f docker-compose.monitoring.yml up -d
	@echo "✅ Services started!"
	@echo "📊 Grafana: http://localhost:3001 (admin/admin123)"
	@echo "📈 Prometheus: http://localhost:9090"
	@echo "🏥 Health Check: http://localhost:3000/health"

monitoring-down:
	@echo "🛑 Stopping monitoring stack..."
	docker-compose -f docker-compose.yml -f docker-compose.monitoring.yml down

monitoring-logs:
	@echo "📋 Viewing monitoring logs..."
	docker-compose -f docker-compose.yml -f docker-compose.monitoring.yml logs -f

install-monitoring:
	@echo "📦 Installing monitoring dependencies..."
	cd nutri-solutions-back && npm install @willsoto/nestjs-prometheus prom-client
	@echo "✅ Dependencies installed!"

setup-monitoring: install-monitoring
	@echo "📁 Creating monitoring directory structure..."
	mkdir -p monitoring/prometheus monitoring/grafana/provisioning/datasources monitoring/grafana/provisioning/dashboards monitoring/grafana/dashboards
	@echo "✅ Monitoring setup complete!"
