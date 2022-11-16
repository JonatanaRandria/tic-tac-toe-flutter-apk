import 'package:flutter/material.dart';
import 'package:tic_tac_toe/operations/game_runner.dart';
import 'package:tic_tac_toe/ui/theme/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIC TAC TOE',
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  

  @override
  State<GameScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GameScreen> {

  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  Game game = Game();
  String result = "";
  List<int> scoreboard = [0,0,0,0,0,0,0,0];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {

    double boardWidth = MediaQuery.of(context).size.width;
   
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("It's ${lastValue} turn".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ) ,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlength ~/3, //I use ~/ besause i won't an integer after division 
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            children: 
              List.generate(Game.boardlength, (index){
                return InkWell(
                  onTap: gameOver? null : (){

                    if(game.board![index]==""){
                       setState(() {
                          game.board![index] =lastValue;
                          turn++;
                          gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                          if(gameOver){
                            result = "${lastValue} is the Winner";
                          }
                          else if(gameOver && turn == 9){
                            result = "It's a Draw!";
                            gameOver = true ;
                          }
                            if(lastValue == "X") 
                                lastValue == "0";
                            else lastValue =="X";
                    });
                    }
                   
                  } ,
                  child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                              child: Text(game.board![index],
                                style: TextStyle(
                                        color: game.board![index] == "X" 
                                                        ? Colors.white70
                                                        : Colors.orangeAccent,
                                        fontSize: 64.0
                                                ),
                                        ) 
                                    ),
                  ),
                );
              })
            ,),
            
          ),
          SizedBox(height: 25.0),
          Text(
            result, style: TextStyle(
                            color: Colors.white,
                            fontSize: 54.0),
          ),
          ElevatedButton.icon(
            onPressed: (){
              setState(() {
                game.board = Game.initGameBoard();
                lastValue == "X";
                turn = 0;
                result = "";
                scoreboard = [0,0,0,0,0,0,0,0];
              });
            }, 
            icon: Icon(Icons.replay),
            label: Text("Repeat the game"),
               ),
        ]
         ),
     );
      
  }
}
