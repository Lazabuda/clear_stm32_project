#include "main.h"
#include <stdint.h>
#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_rcc.h"


// Delay func
void Soft_Delay(volatile uint32_t number)
{
  while(number--);
}


int main (void) 
{
  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
  GPIO_InitTypeDef  ledinit;  // struct creation

  ledinit.GPIO_Mode = GPIO_Mode_OUT;  // direction - output
  ledinit.GPIO_OType = GPIO_OType_PP;  // Push-Pull output
  ledinit.GPIO_PuPd = GPIO_PuPd_NOPULL;  // No pull-up and no pull-down
  ledinit.GPIO_Speed = GPIO_Speed_2MHz;  // Low speed
  ledinit.GPIO_Pin = GPIO_Pin_13; // Led on the Pin 13

  GPIO_Init(GPIOC, &ledinit);
  
  while(1) 
  {
    GPIO_SetBits(GPIOC, GPIO_Pin_13);
    Soft_Delay(0x000FFFFF);
    GPIO_ResetBits(GPIOC, GPIO_Pin_13);
    Soft_Delay(0x000FFFFF);
  }
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

