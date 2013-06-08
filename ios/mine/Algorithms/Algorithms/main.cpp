//
//  main.cpp
//  Algorithms
//
//  Created by Xinjun on 3/06/13.
//  Copyright (c) 2013 Xinjun. All rights reserved.
//

#include <iostream>
#include <stack>

using namespace std;

int fib(int n)
{
    if(n < 2) return n;
    else return fib(n-1) + fib(n-2);
}

int fib_nonrecursive(int n)
{
    
    if(n < 2) return n;
    
    int fib1 = 0;
    int fib2 = 1;
    int tmp = 0;
    
    for (int i = 2; i <= n; i++) {
        tmp = fib2;
        fib2 = fib2 + fib1;
        fib1 = tmp;
    }
    
    return fib2;
}


/*void putQueen(int row)
{
    //for all the columns in row
        if col is available
            if(row < MAX_ROW)
                putQueen(row+1);
            else
                return success;
        take queen from column col
}*/


#define AVALABLE false

class ChessBoard{
    public:
        ChessBoard(int n);
        void findSolutions();
    private:
        bool *rightDiagonal, *leftDiagonal;
        int *queenColNum;
        bool *colStatus; // save flag which row and col is still available
        void putQueen(int row);
        bool isPosAval(int row, int col);
        void printQueen();
        int totalRows;
        int norm;
};

ChessBoard::ChessBoard(int n)
{
    totalRows = n;
    norm = n - 1;
    int i = 0;
    rightDiagonal = new bool[2*n-1];
    for (i = 0; i < 2*n; i++) rightDiagonal[i] = AVALABLE;
    leftDiagonal = new bool[2*n-1];
    for (i = 0; i < 2*n; i++) leftDiagonal[i] = AVALABLE;
    queenColNum = new int[n];
    for (i = 0; i < n; i++) queenColNum[i] = AVALABLE;
    colStatus = new bool[n];
}

bool ChessBoard::isPosAval(int row, int col)
{
    return (colStatus[col] == AVALABLE && rightDiagonal[row-col+norm] == AVALABLE && leftDiagonal[row+col] == AVALABLE);
}

void ChessBoard::printQueen()
{
    cout << "Queen Solution:";
    for (int i = 0; i < totalRows; i++) {
        cout << "(" << i << "," << queenColNum[i] << ") ";
    }
    
    cout << endl;
}

void ChessBoard::putQueen(int row)
{
    for (int col = 0; col < totalRows; col++) {
        if (isPosAval(row, col)) {
            colStatus[col] = !AVALABLE;
            rightDiagonal[row-col+norm] = !AVALABLE;
            leftDiagonal[row+col] = !AVALABLE;
            queenColNum[row] = col;
            
            if(row < totalRows-1){
                putQueen(row+1);
            }else{
                printQueen();
            }
            
            colStatus[col] = AVALABLE;
            rightDiagonal[row-col+norm] = AVALABLE;
            leftDiagonal[row+col] = AVALABLE;
        }
    }
}

void ChessBoard::findSolutions()
{
    putQueen(0);
}

/*
 exitMaze()
 {
    while(currCell){
        if currCell is exit
            return success;
        else{
            set currCell visited;
            push unvisited cells next to currCell into stack;
        }
        currCell = pop (stack);
    }
 }
 */


class Cell{
public:
    Cell(int i, int j){
        x = i;
        y = j;
    }
    bool operator==(const Cell &c) const{
        return (x == c.x && y == c.y);
    }
    
    int x, y;
private:
};

template <class T>
class MyStack: public stack<T>
{
public:
    void push(const T &t){
        Cell *c = (Cell *)t;
        cout << "push (" << c->x << "," << c->y << ")\n";
        stack<T>::push(t);
    }
    
    T pop(){
        T t = this->top();
        stack<T>::pop();
        Cell *c = (Cell *)t;
        cout << "pop (" << c->x << "," << c->y << ")\n";
        return t;
    }
    
};

class Maze{

public:
    Maze();
    char statusAtCell(Cell &c){
        return store[c.x][c.y];
    }
    void findSolution();
    void findSolution1();
    
private:
    MyStack<Cell*> unVisitNode;
    stack<Cell *> visitNode;
    char visited, wall, path;
    char store[5][5] = {{wall, wall, wall, wall, wall}, {wall, wall, path, path, wall}, {wall, path, path, wall, wall}, {wall, path, path, path, path}, {wall, wall, path, wall, wall}};
    Cell *startCell, *endCell;
    void printRoute(){
        cout << "Path:";
        while (!visitNode.empty()) {
            Cell *curCell = visitNode.top();
            visitNode.pop();
            cout << "(" << curCell->x << "," << curCell->y << ") ";
        }
        cout << endl;
    }
    
    bool enterDeadRoute(Cell *c);
    void exitCell(const Cell &c)
    ;
};


Maze::Maze():visited('v'), wall('w'), path('p')
{
    startCell = new Cell(2,2);
    endCell = new Cell(3,4);
}

bool Maze::enterDeadRoute(Cell *curCell)
{
    if ((curCell->x > 0 && store[curCell->x-1][curCell->y] == path) ||
        (curCell->x < 4 && store[curCell->x+1][curCell->y] == path) ||
        (curCell->y > 0 && store[curCell->x][curCell->y-1] == path) ||
        (curCell->y < 4 && store[curCell->x][curCell->y+1] == path) )
        return false;
    return true;
}

void Maze::findSolution()
{
    Cell *curCell = NULL;
    unVisitNode.push(startCell);
    while (!unVisitNode.empty()) {
        
        
        curCell = unVisitNode.pop();
        
        store[curCell->x][curCell->y] = visited;
        visitNode.push(curCell);
        
        if (*curCell == *endCell){
            printRoute();
        }else{
            while(!visitNode.empty() && enterDeadRoute(visitNode.top())) {
                visitNode.pop();
            } 
            
            if (curCell->y > 0 && store[curCell->x][curCell->y-1] == path) {
                unVisitNode.push(new Cell(curCell->x, curCell->y-1));
            }
            
            if (curCell->y < 4 && store[curCell->x][curCell->y+1] == path) {
                unVisitNode.push(new Cell(curCell->x, curCell->y+1));
            }
            if (curCell->x < 4 && store[curCell->x+1][curCell->y] == path) {
                unVisitNode.push(new Cell(curCell->x+1, curCell->y));
            }
            
            if (curCell->x > 0 && store[curCell->x-1][curCell->y] == path) {
                unVisitNode.push(new Cell(curCell->x-1, curCell->y));
            }
        }
    }
}



void Maze::exitCell(const Cell &curCell)
{
    store[curCell.x][curCell.y] = visited;
    cout << "visit (" << curCell.x << "," << curCell.y << ")" << endl;
    if(curCell == *endCell)
        return;
    else{
        if (curCell.y > 0 && store[curCell.x][curCell.y-1] == path) {
            exitCell(Cell(curCell.x, curCell.y-1));
        }
        
        if (curCell.y < 4 && store[curCell.x][curCell.y+1] == path) {
            exitCell(Cell(curCell.x, curCell.y+1));
        }
        
        if (curCell.x > 0 && store[curCell.x-1][curCell.y] == path) {
            exitCell(Cell(curCell.x-1, curCell.y));
        }
        
        if (curCell.x < 4 && store[curCell.x+1][curCell.y] == path) {
            exitCell(Cell(curCell.x+1, curCell.y));
        }
    }
}


void Maze::findSolution1()
{
    exitCell(*startCell);
}


pthread_mutex_t


int main(int argc, const char * argv[])
{

    // insert code here...
    std::cout << "Hello, World!\n";
    std::cout << "fib(4): " << fib(4) << "," << fib_nonrecursive(4) << "\n";
    std::cout << "fib(10): " << fib(10) << "," << fib_nonrecursive(10) << "\n";
    
    //ChessBoard *chess = new ChessBoard(8);
    //chess->findSolutions();
    
    Maze *maze = new Maze();
    maze->findSolution();
    
    Maze *maze1 = new Maze();
    maze1->findSolution1();
    return 0;
}

