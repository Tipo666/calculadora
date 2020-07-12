import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

///
///
///
///
///
void main() => runApp(Calculadora());

class Calculadora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

String strIngreso = "";
final textControllerIngreso = TextEditingController();
final textControllerResultado = TextEditingController();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Colores para los diferentes botones
  Color colorBlanco = const Color(0XFFF9FBFB);
  Color colorGris = Color(0XFF9FBEC3);
  Color azulOscuro = const Color(0XFF0E5C68);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGris,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _panelOperandos(),
          _panelResultado(),
          _panelBotones(),
        ],
      ),
    );
  }

  ///Método btn
  ///
  ///Controla como se ven los botones y su diseño
  ///
  ///Mientras se van digitando los numeros los va concatenando.
  ///
  ///
  ///

  Widget _btn(btntext, Color btnColor, Color textColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(fontSize: 28.0, color: textColor),
        ),
        onPressed: () {
          setState(() {
            textControllerIngreso.text = textControllerIngreso.text + btntext;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  ///
  ///Método btnMasMenos
  ///
  ///Control el diseño de como se ve el boton para cambiar de positivo a negativo y viceversa
  ///
  ///Al presionar el boton, multiplica el numero actual por -1 para cambiarlo, como String.
  ///
  ///
  Widget _btnMasMenos() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child:
            Text("+/-", style: TextStyle(fontSize: 28.0, color: colorBlanco)),
        onPressed: () {
          textControllerIngreso.text =
              (double.parse(textControllerIngreso.text) * -1).toString();
        },
        color: colorGris,
        padding: EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  ///Método btnC
  ///
  ///Controla el diseño del boton "Clear" o "Limpiar"
  ///
  ///Al presionar el boton, se inicializa tanto el resultado como los operandos y operadores
  ///
  ///
  Widget _btnC(btnTexto, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btnTexto,
          style: TextStyle(
              fontSize: 28.0, color: colorBlanco, fontFamily: 'RobotoMono'),
        ),
        //Limpiamos el panel de Operandos.
        onPressed: () {
          setState(() {
            textControllerIngreso.text = "";
            textControllerResultado.text = "";
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  ///Metodo btnIgual
  ///
  ///
  ///Metodo que controla el diseño del boton "Igual"
  ///
  ///Al presionar este botón, se evalua la expresión actual con el operando que se selccionó
  ///
  ///
  Widget _btnIgual(btnText) {
    return FlatButton(
      padding: EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(),
      color: azulOscuro,
      child: Text(
        btnText,
        style: TextStyle(fontSize: 28.0, color: colorBlanco),
      ),
      onPressed: () {
        //Validamos que el campo no este vacio para no trabajar con nulos
        if (textControllerIngreso.text.isNotEmpty) {
          //Expresion para Parsear
          Parser p = Parser();
          ContextModel cm = ContextModel();
          Expression exp = p.parse(textControllerIngreso.text);
          setState(() {
            textControllerResultado.text =
                exp.evaluate(EvaluationType.REAL, cm).toString();
          });
        }
      },
    );
  }

  ///Método panelResultado
  ///
  ///Este método controla como se ve el resultado
  ///
  ///Tambien presenta el resultado en un TextField
  ///
  ///
  ///
  _panelResultado() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
          controller: textControllerResultado,
        ));
  }

  ///Método PanelOperandos
  ///
  ///Controla como se ven los operandos y operadores
  ///
  ///Inicialmente se presenta un "0"
  ///
  ///En este metodo se muestran los operandos y operadores
  ///
  ///
  ///
  _panelOperandos() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          decoration: InputDecoration.collapsed(
              hintText: "0",
              hintStyle: TextStyle(
                fontSize: 15,
              )),
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.right,
          controller: textControllerIngreso,
        ));
  }

  ///Método panelBotones
  ///
  ///Método que controla el diseño de la matoria de los botones
  ///
  ///
  ///
  ///
  ///
  ///

  _panelBotones() {
    return Container(
      color: colorBlanco,
      child: Column(
        children: <Widget>[
          //Separamos el contener del Scaffold visualmente
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _btnC(
                'C',
                colorGris,
              ),
              _btnMasMenos(),
              _btn('%', colorGris, colorBlanco),
              _btn('/', colorGris, colorBlanco),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _btn('7', colorBlanco, azulOscuro),
              _btn('8', colorBlanco, azulOscuro),
              _btn('9', colorBlanco, azulOscuro),
              _btn('*', colorGris, colorBlanco),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _btn('4', colorBlanco, azulOscuro),
              _btn('5', colorBlanco, azulOscuro),
              _btn('6', colorBlanco, azulOscuro),
              _btn('-', colorGris, colorBlanco),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _btn('1', colorBlanco, azulOscuro),
              _btn('2', colorBlanco, azulOscuro),
              _btn('3', colorBlanco, azulOscuro),
              _btn('+', colorGris, colorBlanco),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _btn('0', colorBlanco, azulOscuro),
              _btn('', colorBlanco, azulOscuro),
              _btn('.', colorBlanco, azulOscuro),
              _btnIgual('='),
            ],
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
