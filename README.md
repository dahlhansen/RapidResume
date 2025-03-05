# 🚀 RapidResume  
*A SwiftUI-powered resume builder with a FastAPI backend and LaTeX-based PDF generation.*

## 📌 Overview  

Finding a great job opportunity should be exciting, not frustrating. **RapidResume** was created to solve a common problem: discovering interesting jobs while on the go but not having an easy way to create a polished resume quickly.  

Too often, online resume templates are rigid, clunky, or require endless formatting tweaks, turning what should be a simple process into a frustrating one.  

With **RapidResume**, you can effortlessly craft a professional, well-structured resume without worrying about formatting. The app provides an **intuitive and streamlined experience**, allowing you to focus on your content while it takes care of the design. Whether you're applying from your phone or just need a quick update, **RapidResume ensures your application is always job-ready.**  

## 🛠 Tech Stack  

### Frontend (iOS App)
- **SwiftUI** – UI framework for a modern, declarative user interface.  
- **PDFKit** – Renders and previews resumes within the app.  
- **URLSession** – Handles API requests for fetching the generated PDF.  

### Backend (FastAPI Server)
- **FastAPI** – High-performance backend for handling requests.  
- **Pydantic** – Ensures strong data validation for user input.  
- **Jinja2** – Template engine for dynamically generating LaTeX documents.  
- **LaTeX** – Converts structured resume data into a professional-looking PDF.  
- **Uvicorn** – ASGI server to deploy the FastAPI backend.  

## ⚡ Features  
✔️ **Enter Resume Details** – Users provide structured input such as education, experience, skills, and projects.  
✔️ **Generate Resume (LaTeX PDF)** – Data is processed and converted into a LaTeX-based resume.  
✔️ **Preview Resume** – The PDF is displayed within the app using PDFKit.  
✔️ **Download Resume** – Users can download the generated resume to their device.  

## 🎯 API Endpoints  

| Method  | Endpoint         | Description                            |
|---------|-----------------|----------------------------------------|
| **POST** | `/submit_resume` | Submit resume data (JSON format)     |
| **GET**  | `/get_pdf`      | Retrieve generated PDF resume         |

## 📌 Future Enhancements  
- [ ] Allow user to select order of major categories.  
- [ ] Cloud storage support for resume files.  
- [ ] User authentication & account system.  

