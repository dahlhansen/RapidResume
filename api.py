import subprocess
from jinja2 import Environment, FileSystemLoader
import jinja2
from pydantic import BaseModel
from typing import List
from fastapi import FastAPI

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


@app.post("/submit_resume/")
async def submit_resume(resume: Resume):
    createResume(resume)
    return {"message": "Resume submitted successfully!"}


def createResume(data: Resume):
    env = Environment(loader=FileSystemLoader("."))

    template = env.get_template("resume_template.tex")

    try:
        rendered_tex = template.render(data)

        # 🔥 Print rendered LaTeX for debugging
        print("\n==== Rendered LaTeX Template Start ====")
        print(rendered_tex)
        print("==== Rendered LaTeX Template End ====\n")

        with open("resume_output.tex", "w", encoding="utf-8") as f:
            f.write(rendered_tex)

        subprocess.run(["pdflatex", "resume_output.tex"], check=True)
        print("✅ PDF generated: resume_output.pdf")

    except jinja2.TemplateSyntaxError as e:
        print(f"Jinja2 Template Error: {e.message}")
        print(f"Problem in File: {e.filename} at Line {e.lineno}")

