import subprocess
from jinja2 import Environment, FileSystemLoader
import jinja2
from pydantic import BaseModel
from typing import List
from fastapi import FastAPI
from fastapi.responses import FileResponse
import os

app = FastAPI()

#basemodel used to validate data types
class EducationEntry(BaseModel):
    institution: str
    location: str
    degree: str
    dates: str
    details: List[str]

class SkillEntry(BaseModel):
    category: str
    entries: List[str]

class ProjectEntry(BaseModel):
    title: str
    tech_stack: str
    dates: str
    bullets: List[str]

class ExperienceEntry(BaseModel):
    role: str
    dates: str
    company: str
    location: str
    details: List[str]

class ActivityEntry(BaseModel):
    title: str
    dates: str
    organization: str
    location: str
    details: List[str]

class Resume(BaseModel):
    name: str
    phone: str
    email: str
    linkedin: str
    github: str
    education: List[EducationEntry]
    skills: List[SkillEntry]
    projects: List[ProjectEntry]
    experiences: List[ExperienceEntry]
    activities: List[ActivityEntry]

class CoverLetter(BaseModel):
    name: str
    phone: str
    email: str
    linkedin: str
    github: str
    date: str
    hiring_manager_name: str
    company_name: str
    company_address: str
    salutation_name: str
    paragraph1: str
    paragraph2: str
    paragraph3: str
    paragraph4: str
    closing_paragraph: str
    full_name: str  

#Starting point for api
@app.get("/")
def home():
    return {"message": "Welcome to RapidResume API!"}


#Post request to submit resume
@app.post("/submit_resume/")
async def submit_resume(resume: Resume):
    createResume(resume)
    return {"message": "Resume submitted successfully!"}

#Send pdf file to user in frontend
@app.get("/get_pdf")
async def get_pdf():
    file_path = "resume_output.pdf"
    return FileResponse(file_path, media_type="application/pdf", filename="resume.pdf")


#Resume
def createResume(data: Resume):
    env = Environment(loader=FileSystemLoader("."))

    template = env.get_template("resume_template.tex")

    try:
        rendered_tex = template.render(data)

        with open("resume_output.tex", "w", encoding="utf-8") as f:
            f.write(rendered_tex)

        subprocess.run(["pdflatex", "resume_output.tex"], check=True)
        print("PDF generated: resume_output.pdf")

    except jinja2.TemplateSyntaxError as e:
        print(f"Jinja2 Template Error: {e.message}")
        print(f"Problem in File: {e.filename} at Line {e.lineno}")


#Cover Letter
def createCoverLetter(data: CoverLetter):
    env = Environment(loader=FileSystemLoader("."))

    template = env.get_template("cover_letter_template.tex")

    try:
        rendered_tex = template.render(data)

        with open("cover_letter_output.tex", "w", encoding="utf-8") as f:
            f.write(rendered_tex)

        subprocess.run(["pdflatex", "cover_letter_output.tex"], check=True)
        print("PDF generated: cover_letter_output.pdf")

    except jinja2.TemplateSyntaxError as e:
        print(f"Jinja2 Template Error: {e.message}")
        print(f"Problem in File: {e.filename} at Line {e.lineno}")

@app.post("/submit_cover_letter/")
async def submit_cover_letter(cover_letter: CoverLetter):
    createCoverLetter(cover_letter)
    return {"message": "Cover Letter submitted successfully!"}

if __name__ == "__main__":
    os.system("uvicorn api:app --host 0.0.0.0 --port 8000 --reload --log-level debug")