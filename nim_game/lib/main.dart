import 'package:nim_game/components/app_bar.dart';
import 'package:nim_game/components/button.dart';
import 'package:nim_game/components/drawer_menu.dart';
import 'package:nim_game/components/form_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 53, 210, 129)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController sticksTotalController = TextEditingController();
  TextEditingController sticksLimitController = TextEditingController();

  TextEditingController moveController = TextEditingController();

  int numberOfPieces = 0;
  int limit = 0;
  bool computerPlay = false;
  List<String> moviments = [];

  @override
  void initState() {
    super.initState();
  }

  void snackBar(String text, Color backgroundColor, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(text),
        action: SnackBarAction(
          backgroundColor: cor,
          textColor: Colors.white,
          label: "Ok",
          onPressed: () {},
        ),
      ),
    );
  }

  void messageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    numberOfPieces = int.tryParse(sticksTotalController.text) ?? 0;
    limit = int.tryParse(sticksLimitController.text) ?? 0;

    if (numberOfPieces < 2) {
      snackBar("Total de palitos inválidos. Deve ser igual ou maior que 2",
          Colors.red, const Color.fromARGB(255, 243, 161, 161));
      return;
    }

    if (limit <= 0 || limit >= numberOfPieces) {
      snackBar(
          "Limite de palitos inválidos. Deve ser maior que zero e menor que o total de palitos",
          Colors.red,
          const Color.fromARGB(255, 243, 161, 161));
      return;
    }

    setState(() {
      moviments.clear();
    });

    setState(() {
      computerPlay = (numberOfPieces % (limit + 1)) == 0;
    });

    if (!computerPlay) {
      userPlay();
    } else {
      computerMove();
    }
  }

  void userPlay() {
    moviments.add("Sua vez!!! Faça uma jogada");
  }

  void updateGame(int move) {
    setState(() {
      numberOfPieces -= move;
      moviments
          .add("Você tirou $move palito(s). Restam $numberOfPieces palitos.");
      if (numberOfPieces == 1) {
        endGame();
      } else {
        computerPlay = !computerPlay;
        if (computerPlay) {
          computerMove();
        } else {
          userPlay();
        }
      }
    });
  }

  void computerMove() {
    int computerMove = computerChoosesMove(numberOfPieces, limit);
    setState(() {
      numberOfPieces -= computerMove;
      moviments.add(
          "O computador tirou $computerMove palito(s). Restam $numberOfPieces palitos.");

      computerPlay = !computerPlay;

      if (numberOfPieces == 1) {
        endGame();
      } else {
        userPlay();
      }
    });
  }

  int computerChoosesMove(int numberOfPieces, int limit) {
    int remainder = numberOfPieces % (limit + 1);
    if (remainder == 0) {
      return limit;
    } else {
      return (remainder - 1) == 0 ? limit : (remainder - 1);
    }
  }

  void restartGame() {
    setState(() {
      numberOfPieces = 0;
      limit = 0;

      sticksTotalController.text = "";
      sticksLimitController.text = "";
      moveController.text = "";
    });
  }

  void processUserMove() {
    int move = int.tryParse(moveController.text) ?? 0;
    if (move < 1 || move > limit) {
      snackBar(
        "Jogada inválida! Tente novamente",
        Colors.red,
        const Color.fromARGB(255, 243, 161, 161),
      );
    } else {
      updateGame(move);
      setState(() {
        moveController.text = "";
      });
    }
  }

  void endGame() {
    String result = computerPlay ? "Você ganhou!" : "Computador ganhou!";
    messageDialog(result, 'Fim do jogo.');
    moviments.add(result);

    restartGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth >= 600) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FormText(
                                    controller: sticksTotalController,
                                    text: "Total de Palitos"),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: FormText(
                                  controller: sticksLimitController,
                                  text: "Limite de palitos por jogada",
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Button(
                                    function: startGame, text: "Começar"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: FormText(
                                    controller: moveController,
                                    text: "Sua jogada"),
                              ),
                              Expanded(
                                child: Button(
                                    function: processUserMove, text: "Jogar"),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          FormText(
                              controller: sticksTotalController,
                              text: "Total de Palitos"),
                          FormText(
                            controller: sticksLimitController,
                            text: "Limite de palitos por jogada",
                          ),
                          const SizedBox(height: 20),
                          Button(function: startGame, text: "Começar"),
                          const SizedBox(height: 40),
                          FormText(
                              controller: moveController, text: "Sua jogada"),
                          const SizedBox(height: 25),
                          Button(function: processUserMove, text: "Jogar"),
                        ],
                      );
                    }
                  }),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Andamento do Jogo",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: moviments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                moviments[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
