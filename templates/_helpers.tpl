{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to
this (by the DNS naming spec). If release name contains chart name it will
be used as a full name.
*/}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "app.namespace" -}}
{{- default .Release.Namespace .Values.namespace -}}
{{- end -}}

{{/*
Set's the container resources if the user has set any.
*/}}
{{- define "app.resources" -}}
  {{- if .Values.resources -}}
          resources:
{{ toYaml .Values.resources | indent 12}}
  {{ end }}
{{- end -}}

{{/*
Sets the deployment update strategy
*/}}
{{- define "app.strategy" -}}
  {{- if .Values.strategy }}
  strategy:
  {{- $tp := typeOf .Values.strategy }}
  {{- if eq $tp "string" }}
    {{ tpl .Values.strategy . | nindent 4 | trim }}
  {{- else }}
    {{- toYaml .Values.strategy | nindent 4 }}
  {{- end }}
  {{- end }}
{{- end -}}

