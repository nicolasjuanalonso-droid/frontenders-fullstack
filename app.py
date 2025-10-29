from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '''
    <h1>Hello, World com Flask!</h1>
    <nav>
        <a href="/sobre">Sobre</a> - 
        <a href="/contatos">Contatos</a>
    </nav>
    '''

@app.route('/sobre')
def about_page():
    return 'Página sobre'

@app.route("/contatos")
def contacts_page():
    contato = '<h1>Faça contato</h1>'
    return contato

@app.route("/usuario/login")
def user_login():
    return "<h1>Faça Login</h1>"

if __name__ == '__main__':
    app.run(debug=True)