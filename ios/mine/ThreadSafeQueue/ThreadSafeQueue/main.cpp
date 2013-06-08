//
//  main.cpp
//  ThreadSafeQueue
//
//  Created by Xinjun Email on 28/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <iostream>
#include <string>
#include <queue>
#include <stack>
#include "pthread.h"

using namespace std;

class BinaryTree{
    int value;
    BinaryTree *left;
    BinaryTree *right;
    bool visit;
    
    void depth_traverse(BinaryTree *root)
    {
        stack<BinaryTree*> *treeStack = new stack<BinaryTree*>();
        if(root) treeStack->push(root);
        while (!treeStack->empty()){
            BinaryTree *top = treeStack->top();
            treeStack->pop();
            cout << "visit value:" << top->value << endl; 
            if (root->left) treeStack->push(root->left);
            if (root->right) treeStack->push(root->right);
        }
    }
    
    void breadth_traverse(BinaryTree *root)
    {
        queue<BinaryTree*> *treeQueue = new queue<BinaryTree*>();
        if(root) treeQueue->push(root);
        while (!treeQueue->empty()){
            BinaryTree *top = treeQueue->front();
            treeQueue->pop();
            cout << "visit value:" << top->value << endl; 
            if (root->left) treeQueue->push(root->left);
            if (root->right) treeQueue->push(root->right);
        }
    }
    
    
    void traverse_middle(BinaryTree *root)
    {
        stack<BinaryTree*> *treeStack = new stack<BinaryTree*>();
        if(root) treeStack->push(root);
        while (!treeStack->empty()){
            BinaryTree *top = treeStack->top();
            treeStack->pop();
            cout << "visit value:" << top->value << endl; 
            if (root->right) treeStack->push(root->right);
            if (root->left) treeStack->push(root->left);
            
        }
    }
    
    void traverse_left(BinaryTree *root)
    {
        stack<BinaryTree*> *treeStack = new stack<BinaryTree*>();
        if(root) treeStack->push(root);
        while (!treeStack->empty()) {
            BinaryTree *top = treeStack->top();
            treeStack->pop();
            if (top->visit) {
                cout << "visit value:" << top->value << endl;
                if (top->right) treeStack->push(top->right);
            }
            else {
                top->visit = true;
                treeStack->push(top);
                if (top->left) treeStack->push(top->left);
            }
        }
    }
    
    void traverse_last(BinaryTree *root)
    {
        stack<BinaryTree*> *treeStack = new stack<BinaryTree*>();
        if(root) treeStack->push(root);
        while (!treeStack->empty()) {
            BinaryTree *top = treeStack->top();
            treeStack->pop();
            if (top->visit) {
                cout << "visit value:" << top->value << endl;
                
            }
            else {
                top->visit = true;
                treeStack->push(top);
                if (top->right) treeStack->push(top->right);
                if (top->left) treeStack->push(top->left);
            }
        }
    }
    
    
};


class ThreadSafeStack
{
public:
    
    void push(string value)
    {
        pthread_mutex_lock(&mutex);
        bool isEmpty = stringStack.empty(); 
        stringStack.push(value);
        pthread_mutex_unlock(&mutex);
        
        if (isEmpty) {
            pthread_cond_signal(&signal);
        }
    }
    
    string pop()
    {
        string ret = NULL;
        pthread_mutex_lock(&mutex);
        if (!stringStack.empty()) {
            ret = stringStack.top();
            stringStack.pop();
        }
        pthread_mutex_unlock(&mutex);
        return ret;
    }
    
    string wait_pop()
    {
        string ret = NULL;
        pthread_mutex_lock(&mutex);
        
        while (stringStack.empty()) 
            pthread_cond_wait(&signal, &mutex);
        ret = stringStack.top();
        stringStack.pop();
    
        pthread_mutex_unlock(&mutex);
        return ret;
    }
    
private:
    stack<string> stringStack;
    pthread_mutex_t mutex;
    pthread_cond_t  signal;
};


class ThreadSafeQueue{
  public:
    
    ThreadSafeQueue()
    {
        pthread_mutex_init(&mutex, NULL);
        pthread_cond_init(&cond, NULL);
    }
    
    virtual ~ThreadSafeQueue()
    {
        pthread_mutex_destroy(&mutex);
        pthread_cond_destroy(&cond);
    }
    
    string dequeue()
    {
        
        pthread_mutex_lock(&mutex);
        string value = NULL;
        while (myQueue.empty()) 
        {
            pthread_cond_wait(&cond, &mutex);
        }
        value = myQueue.front();
        myQueue.pop();
        pthread_mutex_unlock(&mutex);
        return value;
    }
    
    void enqueue(string value)
    {
        pthread_mutex_lock(&mutex);
        bool isEmpty = myQueue.empty();
        myQueue.push(value);
        pthread_mutex_unlock(&mutex);
        
        if (isEmpty) {
            pthread_cond_signal(&cond);
        }
    }
    
  private:
    queue<string> myQueue;
    pthread_mutex_t mutex;
    pthread_cond_t cond;
};


int main(int argc, const char * argv[])
{

    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}

