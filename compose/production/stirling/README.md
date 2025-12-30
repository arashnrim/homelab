# Stirling-PDF

Stirling-PDF is a locally hosted web application that allows you to perform various operations on PDF files such as splitting, merging, converting, and applying OCR. It provides a user-friendly interface for PDF manipulation without relying on external services.

# Things to note

- The setup includes optional training data for OCR languages. Additional OCR languages beyond English (en_GB) can be enabled by adding language packs to `/etc/homelab/stirling/trainingData`.
- Configuration files can be customized by placing them in `/etc/homelab/stirling/extraConfigs`.
- Custom files and pipelines can be added to `/etc/homelab/stirling/customFiles/` and `/etc/homelab/stirling/pipeline/` respectively.
