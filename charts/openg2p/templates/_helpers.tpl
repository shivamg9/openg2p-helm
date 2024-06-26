{{/*
Expand the name of the chart.
*/}}
{{- define "openg2p.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "openg2p.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "openg2p.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openg2p.labels" -}}
helm.sh/chart: {{ include "openg2p.chart" . }}
{{ include "openg2p.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openg2p.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openg2p.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* All hostnames */}}

{{/* TODO: perform check here if ingress/istio */}}
{{- define "openg2p.adminHostname" -}}
{{- if .Values.istio.virtualservice.host -}}
{{ .Values.istio.virtualservice.host }}
{{- else -}}
{{ .Values.global.hostname }}
{{- end -}}
{{- end -}}

{{/* TODO: perform check here if ingress/istio */}}
{{- define "openg2p.selfServiceHostname" -}}
{{- if .Values.selfServiceIngress.istio.virtualservice.host -}}
{{ .Values.selfServiceIngress.istio.virtualservice.host }}
{{- else -}}
{{ .Values.global.selfServiceHostname }}
{{- end -}}
{{- end -}}

{{/* TODO: perform check here if ingress/istio */}}
{{- define "openg2p.serviceProviderHostname" -}}
{{- if .Values.serviceProviderIngress.istio.virtualservice.host -}}
{{ .Values.serviceProviderIngress.istio.virtualservice.host }}
{{- else -}}
{{ .Values.global.serviceProviderHostname }}
{{- end -}}
{{- end -}}

{{/* End - All hostnames */}}
