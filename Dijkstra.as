﻿package  {		public class Dijkstra {		public function Dijkstra() {			// constructor code		}				static function routeFromTo(x1:int, y1:int, x2:int, y2:int, grid:Grid):Node{			var openList = new Array();			var closedList = new Array();			openList.push(new Node(x1,y1,0,null));			while (openList.length > 0){				var currentNode:Node = popSmallestNode(openList);				if (currentNode.x == x2 && currentNode.y == y2) return currentNode;				expandNode(currentNode, openList, closedList,grid,x2,y2);				closedList.push(currentNode);			}			return null;		}				static function routeToArray(finalNode):Array {			var n:Node = finalNode;			var nodeArray:Array = new Array();			nodeArray.push(n);			while (n.preNode != null) {				n = n.preNode;				nodeArray.push(n);			}			return nodeArray;		}				static function popSmallestNode(list: Array):Node{			if (list.length <= 0) return null;			var smallestIndex:int = 0;			var smallestCost:int = list[0].cost;			for (var i:int = 1; i<list.length; i++){				if (list[i].cost < smallestCost){					smallestIndex = i;					smallestCost = list[i].cost;				}			}			var retNode = list[smallestIndex];			list[smallestIndex] = list[list.length-1];			list.pop();			return retNode;		}				static function expandNode(currentNode:Node, openList: Array, closedList: Array, grid:Grid,targetX:int,targetY:int):void {			addNodeIfPossible(currentNode, 1, 0, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, -1, 0, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, 0, 1, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, 0, -1, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, 1, 1, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, -1, 1, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, -1, -1, openList, closedList, 2,grid,targetX,targetY);			addNodeIfPossible(currentNode, 1, -1, openList, closedList, 2,grid,targetX,targetY);		}				static function addNodeIfPossible(currentNode:Node, relX:int, relY:int, openList: Array, closedList: Array, newCost:int, grid:Grid, targetX:int, targetY:int): void {			var nextX:int = currentNode.x+relX;			var nextY:int = currentNode.y+relY;			if(nextX<0) return;			if(nextY<0) return;			if(nextX>=Grid.XSIZE) return;			if(nextY>=Grid.YSIZE) return;			if (grid.getTile(nextX, nextY).getObstacle()!=null  && !(targetX==nextX && targetY==nextY)) return;			if (getNodeAt(closedList, nextX, nextY) != null) return;			var existingNode:Node = getNodeAt(openList,nextX,nextY);			var nextCost = currentNode.cost+newCost;			if (existingNode == null){				openList.push(new Node(nextX, nextY, nextCost, currentNode));			}			else {				if (nextCost<existingNode.cost){					existingNode.preNode = currentNode;					existingNode.cost = nextCost;				}			}		}				static function getNodeAt(list: Array, x:int, y:int):Node {			for(var i:int = 0; i<list.length; i++) {				if (list[i].x == x && list[i].y == y) return list[i];			}			return null;		}	}	}