//+------------------------------------------------------------------+
//|                                                Bot_Martingal.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string botName = "GogiBot";
int orderDirection = OP_SELL;
double lotSize = 0.01;
double StopLoss=0;
double TakeProfit = 600;

int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){

}

// Co lenh dang chay ===>  SELL/BUY
// SELL: Tim entry point cua lenh [moi nhat] (co entry point LON nhat)
//         Tim ton so lot cua cac lenh dang chay

void OnTick(){
   int total = get_Number_of_Orders_Running_by_bot();
   if(total==0){
      double stopLoss = 0;
      double takeProfit = 0;
      if(orderDirection==OP_SELL){
         //stopLoss = NormalizeDouble(Ask+StopLoss*Point, Digits);
         takeProfit = NormalizeDouble(Ask-TakeProfit*Point, Digits);
      }
      if(orderDirection==OP_BUY){
         //stopLoss = NormalizeDouble(Bid-StopLoss*Point, Digits);
         takeProfit = NormalizeDouble(Bid+TakeProfit*Point, Digits);
      }
      int ticket = OrderSend(Symbol(), orderDirection, lotSize, Ask, 3, stopLoss, takeProfit, botName, 8888, 0, clrGreen);
   }
}

int get_Number_of_Orders_Running_by_bot(){
   int totalOrders = 0;
   if( OrdersTotal()>0 ){
      for(int pos=0; pos<OrdersTotal(); pos++){
         if(OrderSelect(pos, SELECT_BY_POS)==false) continue;
         if(OrderComment()==botName){
            totalOrders++;
         }   
      }

   }
   return totalOrders;
}
