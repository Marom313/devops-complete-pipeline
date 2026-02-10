from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    msg_html="""
    <div style="text-align:center; font-family:Arial; margin-top:100px;">
        <h1>Hello</h1>
        <h2>This is Marom Gigi DevOps Home Assignment 🚀</h2>
        <p>If you see this, the app is running and containerized :)</p>
    </div>
    """
    return msg_html

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
