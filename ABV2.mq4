//+------------------------------------------------------------------+
//|                                                          ABV2.mq4 |
//|                                                       Alper Ünlü |
//|                                         http://www.alperunlu.net |
//+------------------------------------------------------------------+
#property copyright "Alper Ünlü"
#property link      "http://www.alperunlu.net"
 
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 DodgerBlue
//---- input parameters
extern int ExtABV2AppliedPrice=0;
//---- buffers
double ExtABV2Buffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string sShortName;
//---- indicator buffer mapping
   SetIndexBuffer(0,ExtABV2Buffer);
//---- indicator line
   SetIndexStyle(0,DRAW_LINE);
//---- sets default precision format for indicators visualization
   IndicatorDigits(0);     
//---- name for DataWindow and indicator subwindow label
   sShortName="ABV2";
   IndicatorShortName(sShortName);
   SetIndexLabel(0,sShortName);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| On Balance Volume                                                |
//+------------------------------------------------------------------+
int start()
  {
   int    i,nLimit,nCountedBars;
   //katsayý
int fiyat;
int hacim;



   
//---- bars count that does not changed after last indicator launch.
   nCountedBars=IndicatorCounted();
//---- last counted bar will be recounted
   if(nCountedBars>0) nCountedBars--;
   nLimit=Bars-nCountedBars-1;
//---- 
   for(i=nLimit; i>=0; i--)
     {
      if(i==Bars-1)
         ExtABV2Buffer[i]=Volume[i];
      else
      
         double dCurrentPrice=GetAppliedPrice(ExtABV2AppliedPrice, i);
         double dPreviousPrice=GetAppliedPrice(ExtABV2AppliedPrice, i+1);
         
         if(dCurrentPrice==dPreviousPrice)  
         {
            ExtABV2Buffer[i]=ExtABV2Buffer[i+1];
         }
       
        if(dCurrentPrice<dPreviousPrice) {
        fiyat = 0;
        }
        else {
        fiyat = 1;
      }
             
              
         if (Volume[i]<Volume[i+1])
         {
         hacim = 0;}
         else{
         hacim = 1;
          }
      
      
      if (hacim == 1 & fiyat == 1)
      {
      ExtABV2Buffer[i]=ExtABV2Buffer[i+1]+Volume[i];  
      }          
      
      if (hacim == 1 & fiyat == 0)
      {
      ExtABV2Buffer[i]=ExtABV2Buffer[i+1]-Volume[i];  
      }          
      
      if (hacim == 0 & fiyat == 1)
      {
      ExtABV2Buffer[i]=ExtABV2Buffer[i+1]-Volume[i];  
      }   
      
      if (hacim == 0 & fiyat == 0)
      {
      ExtABV2Buffer[i]=ExtABV2Buffer[i+1]+Volume[i];  
      }         
      
        }
     }
//----
   return(0);
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetAppliedPrice(int nAppliedPrice, int nIndex)
  {
   double dPrice;
//----
   switch(nAppliedPrice)
     {
      case 0:  dPrice=Close[nIndex];                                  break;
      case 1:  dPrice=Open[nIndex];                                   break;
      case 2:  dPrice=High[nIndex];                                   break;
      case 3:  dPrice=Low[nIndex];                                    break;
      case 4:  dPrice=(High[nIndex]+Low[nIndex])/2.0;                 break;
      case 5:  dPrice=(High[nIndex]+Low[nIndex]+Close[nIndex])/3.0;   break;
      case 6:  dPrice=(High[nIndex]+Low[nIndex]+2*Close[nIndex])/4.0; break;
      default: dPrice=0.0;
     }
//----
   return(dPrice);
  }
//+------------------------------------------------------------------+


