#include "main.h"
#include <stdint.h>
#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_rcc.h"

//clock setup in the stm32f4xx.h, strings HSI_VALUE and HSE_VALUE. 16MHz internal quartz, or 25MHz external.

volatile uint8_t TIM2_counter = 0; // Clock interruption counter (0 - LED ON, 1 - LED OFF)

int main (void) 
{
  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE); //Enable GPIO bus
  GPIO_InitTypeDef  GPIO_InitStructure;  // Struct creation

  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;  // Direction - output
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;  // Push-Pull output
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;  // No pull-up and no pull-down
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;  // Low speed
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13; // Led on the Pin 13

  GPIO_Init(GPIOC, &GPIO_InitStructure);
  

  //Timer initialization
  RCC->CR|=((uint32_t)RCC_CR_HSEON); // Bit 16 HSEON: HSE clock enable
	while (!(RCC->CR & RCC_CR_HSERDY)) {}; // Bit 17 HSERDY: HSE clock ready flag
	RCC->CFGR &=~RCC_CFGR_SW; // Clear Bits 1:0 SW: System clock switch
	RCC->CFGR |= RCC_CFGR_SW_HSE; // Choose Bits 1:0 SW: System clock switch -> 01: HSE oscillator selected as system clock

  RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2, ENABLE);  //Enable Timer 6 bus
	TIM2->PSC = 25000 - 1;                                //Prescaler = 1000 ticks per second, frequency 25MHz
	TIM2->ARR = 1000;                                     //Interruption every 1000 ticks (= 1s Delay)
	TIM2->DIER |= TIM_DIER_UIE;                           //Enable interruptions from Timer
	TIM2->CR1 |= TIM_CR1_CEN;                             //Enable Timer
	NVIC_EnableIRQ(TIM2_IRQn);                            //Enable interruption TIM2_IRQn
 
    while(1) {}
}
 
void TIM2_IRQHandler(void)
{
	CLEAR_BIT(TIM2->SR, TIM_SR_UIF);
  //GPIO_ToggleBits(GPIOC, GPIO_Pin_13); // Toggle LED pin.
  
  switch (TIM2_counter)
    {
      case 0: GPIO_SetBits(GPIOC, GPIO_Pin_13); break;
      case 1: GPIO_ResetBits(GPIOC, GPIO_Pin_13); break;
    }
    
    TIM2_counter++;
    
    if(TIM2_counter > 1) 
    {
      TIM2_counter = 0;
    }
}

//example of simple delay - soft_Delay(0x000FFFFF);
void soft_Delay(volatile uint32_t delay)
{
  while(delay--);
}


void Error_Handler(void)
{
  __disable_irq();
  while (1)
  {
  }
}

#ifdef  USE_FULL_ASSERT

void assert_failed(uint8_t *file, uint32_t line)
{
  
}
#endif /* USE_FULL_ASSERT */