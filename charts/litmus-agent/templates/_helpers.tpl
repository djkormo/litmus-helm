{{/*
Expand the name of the chart.
*/}}
{{- define "litmus-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "litmus-agent.fullname" -}}
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
{{- define "litmus-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "litmus-agent.labels" -}}
helm.sh/chart: {{ include "litmus-agent.chart" . }}
{{ include "litmus-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.global.customLabels }}
{{ toYaml .Values.global.customLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "litmus-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "litmus-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common pod annotations
*/}}
{{- define "litmus-agent.podAnnotations" -}}
{{- if .Values.global.podAnnotations }}
{{ toYaml .Values.global.podAnnotations }}
{{- end }}
{{- if .Values.podAnnotations }}
{{ toYaml .Values.podAnnotations }}
{{- end }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "litmus-agent.serviceAccountName" -}}
{{- include "litmus-agent.fullname" . }}
{{- end }}