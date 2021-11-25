terraform {
  required_providers {
    kubernetes = {}
    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.16.0"
    }
  }
}

resource "grafana_data_source" "prometheus" {
  type       = "prometheus"
  name       = "k8s_prometheus"
  url        = var.prometheus_endpoint
  is_default = true
}

resource "grafana_folder" "cluster" {
  title = "Cluster Monitoring"
}

resource "grafana_dashboard" "cluster_rev1" {
  folder = grafana_folder.cluster.id
  config_json = file("${path.module}/dashboards/kubernetes-cluster_rev1.json")
}

resource "grafana_dashboard" "cluster_monitor_rev2" {
  folder = grafana_folder.cluster.id
  config_json = file("${path.module}/dashboards/kubernetes-cluster-monitoring-via-prometheus_rev2.json")
}

resource "grafana_dashboard" "cluster_prometheus_rev1" {
  folder = grafana_folder.cluster.id
  config_json = file("${path.module}/dashboards/kubernetes-cluster-prometheus_rev1.json")
}

