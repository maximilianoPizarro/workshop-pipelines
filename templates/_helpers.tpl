{{/*
Expand the name of the chart.
*/}}
{{- define "workshop-pipelines.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "workshop-pipelines.fullname" -}}
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
{{- define "workshop-pipelines.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "workshop-pipelines.labels" -}}
helm.sh/chart: {{ include "workshop-pipelines.chart" . }}
{{ include "workshop-pipelines.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "workshop-pipelines.selectorLabels" -}}
app.kubernetes.io/name: {{ include "workshop-pipelines.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: workshop-pipelines
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "workshop-pipelines.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "workshop-pipelines.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate docker config json for Quay.io secret
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\":{\"quay.io\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .Values.pipeline.quaySecret.username .Values.pipeline.quaySecret.password .Values.pipeline.quaySecret.email (printf "%s:%s" .Values.pipeline.quaySecret.username .Values.pipeline.quaySecret.password | b64enc) | b64enc }}
{{- end }}