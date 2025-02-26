import subprocess
from jinja2 import Environment, FileSystemLoader


data = {
    "name": "Frederik Dahl Hansen",
    "phone": "416-200-0204",
    "email": "hansenf@sheridancollege.ca",
    "linkedin": "frederik-dahl-hansen",
    "github": "dahlhansen",
    "education": [
        {
            "institution": "Sheridan College",
            "location": "Oakville, ON",
            "degree": "Bachelor of Computer Science (Mobile Computing)",
            "dates": "Jan. 2023 -- May 2026",
            "details": ["GPA: 3.4", "Expected Graduation: December 2026"]
        }
    ],
    
    "skills": [
        {"category": "Languages", "entries": ["Swift", "Java", "Python", "C++"]},
        {"category": "Frameworks", "entries": ["React", "Flask", "Spring Boot"]}
    ],
    "projects": [
        {
            "title": "Nova Weather",
            "tech_stack": "Swift, Firebase, API Integration",
            "dates": "Sept. 2024 -- Dec. 2024",
            "bullets": [
                "Developed a Swift-based weather app with user creation.",
                "Led UI/UX design.",
                "Integrated Firebase Authentication."
            ]
        }
    ],
    "experiences": [
        {
            "role": "Agent Services Coordinator",
            "dates": "Feb. 2024 -- Present",
            "company": "Sutton Group Quantum Realty Inc.",
            "location": "Oakville, ON",
            "details": [
                "Managed front desk operations.",
                "Implemented process improvements."
            ]
        }
    ],
    "activities": [
        {
            "title": "President & Founder",
            "dates": "Oct. 2024 -- Present",
            "organization": "Sheridan Golf Club",
            "location": "Oakville, ON",
            "details": [
                "Founded the club with four peers.",
                "Led event planning and doubled membership."
            ]
        }
    ]
}

env = Environment(loader=FileSystemLoader("."))

template = env.get_template("resume_template.tex")

rendered_tex = template.render(data)

with open("resume_output.tex", "w", encoding="utf-8") as f:
    f.write(rendered_tex)

try:
    subprocess.run(["pdflatex", "resume_output.tex"], check=True)
    print("PDF generated: resume_output.pdf")
except FileNotFoundError:
    print("ERROR: pdflatex not found. Please install a LaTeX distribution.")
except subprocess.CalledProcessError as e:
    print("ERROR: pdflatex compilation failed:", e)
