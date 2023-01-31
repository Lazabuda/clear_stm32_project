
E:/Coding/STM32/Projects/clear_stm32_project/build/Appd.elf:     file format elf32-littlearm


Disassembly of section .text:

08000194 <__do_global_dtors_aux>:
 8000194:	b510      	push	{r4, lr}
 8000196:	4c05      	ldr	r4, [pc, #20]	; (80001ac <__do_global_dtors_aux+0x18>)
 8000198:	7823      	ldrb	r3, [r4, #0]
 800019a:	b933      	cbnz	r3, 80001aa <__do_global_dtors_aux+0x16>
 800019c:	4b04      	ldr	r3, [pc, #16]	; (80001b0 <__do_global_dtors_aux+0x1c>)
 800019e:	b113      	cbz	r3, 80001a6 <__do_global_dtors_aux+0x12>
 80001a0:	4804      	ldr	r0, [pc, #16]	; (80001b4 <__do_global_dtors_aux+0x20>)
 80001a2:	f3af 8000 	nop.w
 80001a6:	2301      	movs	r3, #1
 80001a8:	7023      	strb	r3, [r4, #0]
 80001aa:	bd10      	pop	{r4, pc}
 80001ac:	20000000 	.word	0x20000000
 80001b0:	00000000 	.word	0x00000000
 80001b4:	08000898 	.word	0x08000898

080001b8 <frame_dummy>:
 80001b8:	b508      	push	{r3, lr}
 80001ba:	4b03      	ldr	r3, [pc, #12]	; (80001c8 <frame_dummy+0x10>)
 80001bc:	b11b      	cbz	r3, 80001c6 <frame_dummy+0xe>
 80001be:	4903      	ldr	r1, [pc, #12]	; (80001cc <frame_dummy+0x14>)
 80001c0:	4803      	ldr	r0, [pc, #12]	; (80001d0 <frame_dummy+0x18>)
 80001c2:	f3af 8000 	nop.w
 80001c6:	bd08      	pop	{r3, pc}
 80001c8:	00000000 	.word	0x00000000
 80001cc:	20000004 	.word	0x20000004
 80001d0:	08000898 	.word	0x08000898

080001d4 <Soft_Delay>:
#include "stm32f4xx_rcc.h"


// Функция программной задержки
void Soft_Delay(volatile uint32_t number)
{
 80001d4:	b082      	sub	sp, #8
 80001d6:	9001      	str	r0, [sp, #4]
  while(number--);
 80001d8:	9b01      	ldr	r3, [sp, #4]
 80001da:	1e5a      	subs	r2, r3, #1
 80001dc:	9201      	str	r2, [sp, #4]
 80001de:	2b00      	cmp	r3, #0
 80001e0:	d1fa      	bne.n	80001d8 <Soft_Delay+0x4>
}
 80001e2:	b002      	add	sp, #8
 80001e4:	4770      	bx	lr
	...

080001e8 <main>:


int main (void) 
{
 80001e8:	b500      	push	{lr}
 80001ea:	b083      	sub	sp, #12
  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
 80001ec:	2101      	movs	r1, #1
 80001ee:	2004      	movs	r0, #4
 80001f0:	f000 fa70 	bl	80006d4 <RCC_AHB1PeriphClockCmd>
  GPIO_InitTypeDef  ledinit;  // создаем структуру

  ledinit.GPIO_Mode = GPIO_Mode_OUT;  // направление - выход
 80001f4:	2301      	movs	r3, #1
 80001f6:	f88d 3004 	strb.w	r3, [sp, #4]
  ledinit.GPIO_OType = GPIO_OType_PP;  // Двухтактный выход
 80001fa:	2300      	movs	r3, #0
 80001fc:	f88d 3006 	strb.w	r3, [sp, #6]
  ledinit.GPIO_PuPd = GPIO_PuPd_NOPULL;  // Без подтяжки
 8000200:	f88d 3007 	strb.w	r3, [sp, #7]
  ledinit.GPIO_Speed = GPIO_Speed_2MHz;  // Скорость низкая
 8000204:	f88d 3005 	strb.w	r3, [sp, #5]
  ledinit.GPIO_Pin = GPIO_Pin_13; // Светодиод на 15м выводе
 8000208:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 800020c:	9300      	str	r3, [sp, #0]

  GPIO_Init(GPIOC, &ledinit);
 800020e:	4669      	mov	r1, sp
 8000210:	480a      	ldr	r0, [pc, #40]	; (800023c <main+0x54>)
 8000212:	f000 f8ff 	bl	8000414 <GPIO_Init>
  
  while(1) 
  {
    GPIO_SetBits(GPIOC, GPIO_Pin_13);
 8000216:	4d09      	ldr	r5, [pc, #36]	; (800023c <main+0x54>)
 8000218:	f44f 5100 	mov.w	r1, #8192	; 0x2000
 800021c:	4628      	mov	r0, r5
 800021e:	f000 f99b 	bl	8000558 <GPIO_SetBits>
    Soft_Delay(0x000FFFFF);
 8000222:	4c07      	ldr	r4, [pc, #28]	; (8000240 <main+0x58>)
 8000224:	4620      	mov	r0, r4
 8000226:	f7ff ffd5 	bl	80001d4 <Soft_Delay>
    GPIO_ResetBits(GPIOC, GPIO_Pin_13);
 800022a:	f44f 5100 	mov.w	r1, #8192	; 0x2000
 800022e:	4628      	mov	r0, r5
 8000230:	f000 f9d2 	bl	80005d8 <GPIO_ResetBits>
    Soft_Delay(0x000FFFFF);
 8000234:	4620      	mov	r0, r4
 8000236:	f7ff ffcd 	bl	80001d4 <Soft_Delay>
  while(1) 
 800023a:	e7ec      	b.n	8000216 <main+0x2e>
 800023c:	40020800 	.word	0x40020800
 8000240:	000fffff 	.word	0x000fffff

08000244 <assert_failed>:
#ifdef  USE_FULL_ASSERT

void assert_failed(uint8_t *file, uint32_t line)
{
  
}
 8000244:	4770      	bx	lr

08000246 <NMI_Handler>:
  * @brief   This function handles NMI exception.
  * @param  None
  * @retval None
  */
void NMI_Handler(void)
{
 8000246:	b508      	push	{r3, lr}
  /* This interrupt is generated when HSE clock fails */

  if (RCC_GetITStatus(RCC_IT_CSS) != RESET)
 8000248:	2080      	movs	r0, #128	; 0x80
 800024a:	f000 facd 	bl	80007e8 <RCC_GetITStatus>
 800024e:	b900      	cbnz	r0, 8000252 <NMI_Handler+0xc>

    /* Once HSE clock recovers, the HSERDY interrupt is generated and in the RCC ISR
       routine the system clock will be reconfigured to its previous state (before
       HSE clock failure) */
  }
}
 8000250:	bd08      	pop	{r3, pc}
    RCC_HSEConfig(RCC_HSE_ON);
 8000252:	2001      	movs	r0, #1
 8000254:	f000 fa00 	bl	8000658 <RCC_HSEConfig>
    RCC_ITConfig(RCC_IT_HSERDY | RCC_IT_PLLRDY, ENABLE);
 8000258:	2101      	movs	r1, #1
 800025a:	2018      	movs	r0, #24
 800025c:	f000 fa60 	bl	8000720 <RCC_ITConfig>
    RCC_ClearITPendingBit(RCC_IT_CSS);
 8000260:	2080      	movs	r0, #128	; 0x80
 8000262:	f000 fae5 	bl	8000830 <RCC_ClearITPendingBit>
}
 8000266:	e7f3      	b.n	8000250 <NMI_Handler+0xa>

08000268 <HardFault_Handler>:
  * @retval None
  */
void HardFault_Handler(void)
{
  /* Go to infinite loop when Hard Fault exception occurs */
  while (1)
 8000268:	e7fe      	b.n	8000268 <HardFault_Handler>

0800026a <MemManage_Handler>:
  * @retval None
  */
void MemManage_Handler(void)
{
  /* Go to infinite loop when Memory Manage exception occurs */
  while (1)
 800026a:	e7fe      	b.n	800026a <MemManage_Handler>

0800026c <BusFault_Handler>:
  * @retval None
  */
void BusFault_Handler(void)
{
  /* Go to infinite loop when Bus Fault exception occurs */
  while (1)
 800026c:	e7fe      	b.n	800026c <BusFault_Handler>

0800026e <UsageFault_Handler>:
  * @retval None
  */
void UsageFault_Handler(void)
{
  /* Go to infinite loop when Usage Fault exception occurs */
  while (1)
 800026e:	e7fe      	b.n	800026e <UsageFault_Handler>

08000270 <SVC_Handler>:
  * @param  None
  * @retval None
  */
void SVC_Handler(void)
{
}
 8000270:	4770      	bx	lr

08000272 <DebugMon_Handler>:
  * @param  None
  * @retval None
  */
void DebugMon_Handler(void)
{
}
 8000272:	4770      	bx	lr

08000274 <PendSV_Handler>:
  * @param  None
  * @retval None
  */
void PendSV_Handler(void)
{
}
 8000274:	4770      	bx	lr

08000276 <SysTick_Handler>:
  * @param  None
  * @retval None
  */
void SysTick_Handler(void)
{
}
 8000276:	4770      	bx	lr

08000278 <RCC_IRQHandler>:
  * @brief  This function handles RCC interrupt request. 
  * @param  None
  * @retval None
  */
void RCC_IRQHandler(void)
{
 8000278:	b508      	push	{r3, lr}
  if(RCC_GetITStatus(RCC_IT_HSERDY) != RESET)
 800027a:	2008      	movs	r0, #8
 800027c:	f000 fab4 	bl	80007e8 <RCC_GetITStatus>
 8000280:	b920      	cbnz	r0, 800028c <RCC_IRQHandler+0x14>
      /* Enable PLL: once the PLL is ready the PLLRDY interrupt is generated */ 
      RCC_PLLCmd(ENABLE);     
    }
  }

  if(RCC_GetITStatus(RCC_IT_PLLRDY) != RESET)
 8000282:	2010      	movs	r0, #16
 8000284:	f000 fab0 	bl	80007e8 <RCC_GetITStatus>
 8000288:	b960      	cbnz	r0, 80002a4 <RCC_IRQHandler+0x2c>
    { 
      /* Select PLL as system clock source */
      RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
    }
  }
}
 800028a:	bd08      	pop	{r3, pc}
    RCC_ClearITPendingBit(RCC_IT_HSERDY);
 800028c:	2008      	movs	r0, #8
 800028e:	f000 facf 	bl	8000830 <RCC_ClearITPendingBit>
    if (RCC_GetFlagStatus(RCC_FLAG_HSERDY) != RESET)
 8000292:	2031      	movs	r0, #49	; 0x31
 8000294:	f000 fa68 	bl	8000768 <RCC_GetFlagStatus>
 8000298:	2800      	cmp	r0, #0
 800029a:	d0f2      	beq.n	8000282 <RCC_IRQHandler+0xa>
      RCC_PLLCmd(ENABLE);     
 800029c:	2001      	movs	r0, #1
 800029e:	f000 f9f1 	bl	8000684 <RCC_PLLCmd>
 80002a2:	e7ee      	b.n	8000282 <RCC_IRQHandler+0xa>
    RCC_ClearITPendingBit(RCC_IT_PLLRDY);
 80002a4:	2010      	movs	r0, #16
 80002a6:	f000 fac3 	bl	8000830 <RCC_ClearITPendingBit>
    if (RCC_GetFlagStatus(RCC_FLAG_PLLRDY) != RESET)
 80002aa:	2039      	movs	r0, #57	; 0x39
 80002ac:	f000 fa5c 	bl	8000768 <RCC_GetFlagStatus>
 80002b0:	2800      	cmp	r0, #0
 80002b2:	d0ea      	beq.n	800028a <RCC_IRQHandler+0x12>
      RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
 80002b4:	2002      	movs	r0, #2
 80002b6:	f000 f9f7 	bl	80006a8 <RCC_SYSCLKConfig>
}
 80002ba:	e7e6      	b.n	800028a <RCC_IRQHandler+0x12>

080002bc <SetSysClock>:
  *         is reset to the default reset state (done in SystemInit() function).   
  * @param  None
  * @retval None
  */
static void SetSysClock(void)
{
 80002bc:	b082      	sub	sp, #8
/******************************************************************************/
/*            PLL (clocked by HSE) used as System clock source                */
/******************************************************************************/
  __IO uint32_t StartUpCounter = 0, HSEStatus = 0;
 80002be:	2300      	movs	r3, #0
 80002c0:	9301      	str	r3, [sp, #4]
 80002c2:	9300      	str	r3, [sp, #0]
  
  /* Enable HSE */
  RCC->CR |= ((uint32_t)RCC_CR_HSEON);
 80002c4:	4a29      	ldr	r2, [pc, #164]	; (800036c <SetSysClock+0xb0>)
 80002c6:	6813      	ldr	r3, [r2, #0]
 80002c8:	f443 3380 	orr.w	r3, r3, #65536	; 0x10000
 80002cc:	6013      	str	r3, [r2, #0]
 
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
    HSEStatus = RCC->CR & RCC_CR_HSERDY;
 80002ce:	4b27      	ldr	r3, [pc, #156]	; (800036c <SetSysClock+0xb0>)
 80002d0:	681b      	ldr	r3, [r3, #0]
 80002d2:	f403 3300 	and.w	r3, r3, #131072	; 0x20000
 80002d6:	9300      	str	r3, [sp, #0]
    StartUpCounter++;
 80002d8:	9b01      	ldr	r3, [sp, #4]
 80002da:	3301      	adds	r3, #1
 80002dc:	9301      	str	r3, [sp, #4]
  } while((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));
 80002de:	9b00      	ldr	r3, [sp, #0]
 80002e0:	b91b      	cbnz	r3, 80002ea <SetSysClock+0x2e>
 80002e2:	9b01      	ldr	r3, [sp, #4]
 80002e4:	f5b3 4fa0 	cmp.w	r3, #20480	; 0x5000
 80002e8:	d1f1      	bne.n	80002ce <SetSysClock+0x12>

  if ((RCC->CR & RCC_CR_HSERDY) != RESET)
 80002ea:	4b20      	ldr	r3, [pc, #128]	; (800036c <SetSysClock+0xb0>)
 80002ec:	681b      	ldr	r3, [r3, #0]
 80002ee:	f413 3f00 	tst.w	r3, #131072	; 0x20000
 80002f2:	d006      	beq.n	8000302 <SetSysClock+0x46>
  {
    HSEStatus = (uint32_t)0x01;
 80002f4:	2301      	movs	r3, #1
 80002f6:	9300      	str	r3, [sp, #0]
  else
  {
    HSEStatus = (uint32_t)0x00;
  }

  if (HSEStatus == (uint32_t)0x01)
 80002f8:	9b00      	ldr	r3, [sp, #0]
 80002fa:	2b01      	cmp	r3, #1
 80002fc:	d004      	beq.n	8000308 <SetSysClock+0x4c>
  else
  { /* If HSE fails to start-up, the application will have wrong clock
         configuration. User can add here some code to deal with this error */
  }

}
 80002fe:	b002      	add	sp, #8
 8000300:	4770      	bx	lr
    HSEStatus = (uint32_t)0x00;
 8000302:	2300      	movs	r3, #0
 8000304:	9300      	str	r3, [sp, #0]
 8000306:	e7f7      	b.n	80002f8 <SetSysClock+0x3c>
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
 8000308:	4b18      	ldr	r3, [pc, #96]	; (800036c <SetSysClock+0xb0>)
 800030a:	6c1a      	ldr	r2, [r3, #64]	; 0x40
 800030c:	f042 5280 	orr.w	r2, r2, #268435456	; 0x10000000
 8000310:	641a      	str	r2, [r3, #64]	; 0x40
    PWR->CR |= PWR_CR_VOS;
 8000312:	4917      	ldr	r1, [pc, #92]	; (8000370 <SetSysClock+0xb4>)
 8000314:	680a      	ldr	r2, [r1, #0]
 8000316:	f442 4240 	orr.w	r2, r2, #49152	; 0xc000
 800031a:	600a      	str	r2, [r1, #0]
    RCC->CFGR |= RCC_CFGR_HPRE_DIV1;
 800031c:	689a      	ldr	r2, [r3, #8]
 800031e:	609a      	str	r2, [r3, #8]
    RCC->CFGR |= RCC_CFGR_PPRE2_DIV1;
 8000320:	689a      	ldr	r2, [r3, #8]
 8000322:	609a      	str	r2, [r3, #8]
    RCC->CFGR |= RCC_CFGR_PPRE1_DIV2;
 8000324:	689a      	ldr	r2, [r3, #8]
 8000326:	f442 5280 	orr.w	r2, r2, #4096	; 0x1000
 800032a:	609a      	str	r2, [r3, #8]
    RCC->PLLCFGR = PLL_M | (PLL_N << 6) | (((PLL_P >> 1) -1) << 16) |
 800032c:	4a11      	ldr	r2, [pc, #68]	; (8000374 <SetSysClock+0xb8>)
 800032e:	605a      	str	r2, [r3, #4]
    RCC->CR |= RCC_CR_PLLON;
 8000330:	681a      	ldr	r2, [r3, #0]
 8000332:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 8000336:	601a      	str	r2, [r3, #0]
    while((RCC->CR & RCC_CR_PLLRDY) == 0)
 8000338:	4b0c      	ldr	r3, [pc, #48]	; (800036c <SetSysClock+0xb0>)
 800033a:	681b      	ldr	r3, [r3, #0]
 800033c:	f013 7f00 	tst.w	r3, #33554432	; 0x2000000
 8000340:	d0fa      	beq.n	8000338 <SetSysClock+0x7c>
    FLASH->ACR = FLASH_ACR_PRFTEN | FLASH_ACR_ICEN |FLASH_ACR_DCEN |FLASH_ACR_LATENCY_2WS;
 8000342:	4b0d      	ldr	r3, [pc, #52]	; (8000378 <SetSysClock+0xbc>)
 8000344:	f240 7202 	movw	r2, #1794	; 0x702
 8000348:	601a      	str	r2, [r3, #0]
    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
 800034a:	f5a3 6380 	sub.w	r3, r3, #1024	; 0x400
 800034e:	689a      	ldr	r2, [r3, #8]
 8000350:	f022 0203 	bic.w	r2, r2, #3
 8000354:	609a      	str	r2, [r3, #8]
    RCC->CFGR |= RCC_CFGR_SW_PLL;
 8000356:	689a      	ldr	r2, [r3, #8]
 8000358:	f042 0202 	orr.w	r2, r2, #2
 800035c:	609a      	str	r2, [r3, #8]
    while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS ) != RCC_CFGR_SWS_PLL);
 800035e:	4b03      	ldr	r3, [pc, #12]	; (800036c <SetSysClock+0xb0>)
 8000360:	689b      	ldr	r3, [r3, #8]
 8000362:	f003 030c 	and.w	r3, r3, #12
 8000366:	2b08      	cmp	r3, #8
 8000368:	d1f9      	bne.n	800035e <SetSysClock+0xa2>
 800036a:	e7c8      	b.n	80002fe <SetSysClock+0x42>
 800036c:	40023800 	.word	0x40023800
 8000370:	40007000 	.word	0x40007000
 8000374:	07415419 	.word	0x07415419
 8000378:	40023c00 	.word	0x40023c00

0800037c <SystemInit>:
{
 800037c:	b508      	push	{r3, lr}
  RCC->CR |= (uint32_t)0x00000001;
 800037e:	4b0d      	ldr	r3, [pc, #52]	; (80003b4 <SystemInit+0x38>)
 8000380:	681a      	ldr	r2, [r3, #0]
 8000382:	f042 0201 	orr.w	r2, r2, #1
 8000386:	601a      	str	r2, [r3, #0]
  RCC->CFGR = 0x00000000;
 8000388:	2100      	movs	r1, #0
 800038a:	6099      	str	r1, [r3, #8]
  RCC->CR &= (uint32_t)0xFEF6FFFF;
 800038c:	681a      	ldr	r2, [r3, #0]
 800038e:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 8000392:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 8000396:	601a      	str	r2, [r3, #0]
  RCC->PLLCFGR = 0x24003010;
 8000398:	4a07      	ldr	r2, [pc, #28]	; (80003b8 <SystemInit+0x3c>)
 800039a:	605a      	str	r2, [r3, #4]
  RCC->CR &= (uint32_t)0xFFFBFFFF;
 800039c:	681a      	ldr	r2, [r3, #0]
 800039e:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 80003a2:	601a      	str	r2, [r3, #0]
  RCC->CIR = 0x00000000;
 80003a4:	60d9      	str	r1, [r3, #12]
  SetSysClock();
 80003a6:	f7ff ff89 	bl	80002bc <SetSysClock>
  SCB->VTOR = FLASH_BASE | VECT_TAB_OFFSET; /* Vector Table Relocation in Internal FLASH */
 80003aa:	4b04      	ldr	r3, [pc, #16]	; (80003bc <SystemInit+0x40>)
 80003ac:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 80003b0:	609a      	str	r2, [r3, #8]
}
 80003b2:	bd08      	pop	{r3, pc}
 80003b4:	40023800 	.word	0x40023800
 80003b8:	24003010 	.word	0x24003010
 80003bc:	e000ed00 	.word	0xe000ed00

080003c0 <Reset_Handler>:

    .section  .text.Reset_Handler
  .weak  Reset_Handler
  .type  Reset_Handler, %function
Reset_Handler:  
  ldr   sp, =_estack      /* set stack pointer */
 80003c0:	f8df d034 	ldr.w	sp, [pc, #52]	; 80003f8 <LoopFillZerobss+0x14>

/* Copy the data segment initializers from flash to SRAM */  
  movs  r1, #0
 80003c4:	2100      	movs	r1, #0
  b  LoopCopyDataInit
 80003c6:	e003      	b.n	80003d0 <LoopCopyDataInit>

080003c8 <CopyDataInit>:

CopyDataInit:
  ldr  r3, =_sidata
 80003c8:	4b0c      	ldr	r3, [pc, #48]	; (80003fc <LoopFillZerobss+0x18>)
  ldr  r3, [r3, r1]
 80003ca:	585b      	ldr	r3, [r3, r1]
  str  r3, [r0, r1]
 80003cc:	5043      	str	r3, [r0, r1]
  adds  r1, r1, #4
 80003ce:	3104      	adds	r1, #4

080003d0 <LoopCopyDataInit>:
    
LoopCopyDataInit:
  ldr  r0, =_sdata
 80003d0:	480b      	ldr	r0, [pc, #44]	; (8000400 <LoopFillZerobss+0x1c>)
  ldr  r3, =_edata
 80003d2:	4b0c      	ldr	r3, [pc, #48]	; (8000404 <LoopFillZerobss+0x20>)
  adds  r2, r0, r1
 80003d4:	1842      	adds	r2, r0, r1
  cmp  r2, r3
 80003d6:	429a      	cmp	r2, r3
  bcc  CopyDataInit
 80003d8:	d3f6      	bcc.n	80003c8 <CopyDataInit>
  ldr  r2, =_sbss
 80003da:	4a0b      	ldr	r2, [pc, #44]	; (8000408 <LoopFillZerobss+0x24>)
  b  LoopFillZerobss
 80003dc:	e002      	b.n	80003e4 <LoopFillZerobss>

080003de <FillZerobss>:
/* Zero fill the bss segment. */  
FillZerobss:
  movs  r3, #0
 80003de:	2300      	movs	r3, #0
  str  r3, [r2], #4
 80003e0:	f842 3b04 	str.w	r3, [r2], #4

080003e4 <LoopFillZerobss>:
    
LoopFillZerobss:
  ldr  r3, = _ebss
 80003e4:	4b09      	ldr	r3, [pc, #36]	; (800040c <LoopFillZerobss+0x28>)
  cmp  r2, r3
 80003e6:	429a      	cmp	r2, r3
  bcc  FillZerobss
 80003e8:	d3f9      	bcc.n	80003de <FillZerobss>

/* Call the clock system intitialization function.*/
  bl  SystemInit   
 80003ea:	f7ff ffc7 	bl	800037c <SystemInit>
/* Call static constructors */
    bl __libc_init_array
 80003ee:	f000 fa2f 	bl	8000850 <__libc_init_array>
/* Call the application's entry point.*/
  bl  main
 80003f2:	f7ff fef9 	bl	80001e8 <main>
  bx  lr    
 80003f6:	4770      	bx	lr
  ldr   sp, =_estack      /* set stack pointer */
 80003f8:	20010000 	.word	0x20010000
  ldr  r3, =_sidata
 80003fc:	08000934 	.word	0x08000934
  ldr  r0, =_sdata
 8000400:	20000000 	.word	0x20000000
  ldr  r3, =_edata
 8000404:	20000000 	.word	0x20000000
  ldr  r2, =_sbss
 8000408:	20000000 	.word	0x20000000
  ldr  r3, = _ebss
 800040c:	2000001c 	.word	0x2000001c

08000410 <ADC_IRQHandler>:
 * @retval None       
*/
    .section  .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b  Infinite_Loop
 8000410:	e7fe      	b.n	8000410 <ADC_IRQHandler>
	...

08000414 <GPIO_Init>:
  * @param  GPIO_InitStruct: pointer to a GPIO_InitTypeDef structure that contains
  *         the configuration information for the specified GPIO peripheral.
  * @retval None
  */
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct)
{
 8000414:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8000418:	4605      	mov	r5, r0
 800041a:	460e      	mov	r6, r1
  uint32_t pinpos = 0x00, pos = 0x00 , currentpin = 0x00;

  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 800041c:	4b4c      	ldr	r3, [pc, #304]	; (8000550 <GPIO_Init+0x13c>)
 800041e:	4298      	cmp	r0, r3
 8000420:	d02b      	beq.n	800047a <GPIO_Init+0x66>
 8000422:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000426:	4298      	cmp	r0, r3
 8000428:	d027      	beq.n	800047a <GPIO_Init+0x66>
 800042a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 800042e:	4298      	cmp	r0, r3
 8000430:	d023      	beq.n	800047a <GPIO_Init+0x66>
 8000432:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000436:	4298      	cmp	r0, r3
 8000438:	d01f      	beq.n	800047a <GPIO_Init+0x66>
 800043a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 800043e:	4298      	cmp	r0, r3
 8000440:	d01b      	beq.n	800047a <GPIO_Init+0x66>
 8000442:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000446:	4298      	cmp	r0, r3
 8000448:	d017      	beq.n	800047a <GPIO_Init+0x66>
 800044a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 800044e:	4298      	cmp	r0, r3
 8000450:	d013      	beq.n	800047a <GPIO_Init+0x66>
 8000452:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000456:	4298      	cmp	r0, r3
 8000458:	d00f      	beq.n	800047a <GPIO_Init+0x66>
 800045a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 800045e:	4298      	cmp	r0, r3
 8000460:	d00b      	beq.n	800047a <GPIO_Init+0x66>
 8000462:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000466:	4298      	cmp	r0, r3
 8000468:	d007      	beq.n	800047a <GPIO_Init+0x66>
 800046a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 800046e:	4298      	cmp	r0, r3
 8000470:	d003      	beq.n	800047a <GPIO_Init+0x66>
 8000472:	21cf      	movs	r1, #207	; 0xcf
 8000474:	4837      	ldr	r0, [pc, #220]	; (8000554 <GPIO_Init+0x140>)
 8000476:	f7ff fee5 	bl	8000244 <assert_failed>
  assert_param(IS_GPIO_PIN(GPIO_InitStruct->GPIO_Pin));
 800047a:	8833      	ldrh	r3, [r6, #0]
 800047c:	b13b      	cbz	r3, 800048e <GPIO_Init+0x7a>
  assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
 800047e:	7933      	ldrb	r3, [r6, #4]
 8000480:	2b03      	cmp	r3, #3
 8000482:	d809      	bhi.n	8000498 <GPIO_Init+0x84>
  assert_param(IS_GPIO_PUPD(GPIO_InitStruct->GPIO_PuPd));
 8000484:	79f3      	ldrb	r3, [r6, #7]
 8000486:	2b02      	cmp	r3, #2
 8000488:	d80b      	bhi.n	80004a2 <GPIO_Init+0x8e>
{
 800048a:	2400      	movs	r4, #0
 800048c:	e02f      	b.n	80004ee <GPIO_Init+0xda>
  assert_param(IS_GPIO_PIN(GPIO_InitStruct->GPIO_Pin));
 800048e:	21d0      	movs	r1, #208	; 0xd0
 8000490:	4830      	ldr	r0, [pc, #192]	; (8000554 <GPIO_Init+0x140>)
 8000492:	f7ff fed7 	bl	8000244 <assert_failed>
 8000496:	e7f2      	b.n	800047e <GPIO_Init+0x6a>
  assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
 8000498:	21d1      	movs	r1, #209	; 0xd1
 800049a:	482e      	ldr	r0, [pc, #184]	; (8000554 <GPIO_Init+0x140>)
 800049c:	f7ff fed2 	bl	8000244 <assert_failed>
 80004a0:	e7f0      	b.n	8000484 <GPIO_Init+0x70>
  assert_param(IS_GPIO_PUPD(GPIO_InitStruct->GPIO_PuPd));
 80004a2:	21d2      	movs	r1, #210	; 0xd2
 80004a4:	482b      	ldr	r0, [pc, #172]	; (8000554 <GPIO_Init+0x140>)
 80004a6:	f7ff fecd 	bl	8000244 <assert_failed>
 80004aa:	e7ee      	b.n	800048a <GPIO_Init+0x76>
      GPIOx->MODER |= (((uint32_t)GPIO_InitStruct->GPIO_Mode) << (pinpos * 2));

      if ((GPIO_InitStruct->GPIO_Mode == GPIO_Mode_OUT) || (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_AF))
      {
        /* Check Speed mode parameters */
        assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
 80004ac:	21e4      	movs	r1, #228	; 0xe4
 80004ae:	4829      	ldr	r0, [pc, #164]	; (8000554 <GPIO_Init+0x140>)
 80004b0:	f7ff fec8 	bl	8000244 <assert_failed>
 80004b4:	e038      	b.n	8000528 <GPIO_Init+0x114>

        /* Check Output mode parameters */
        assert_param(IS_GPIO_OTYPE(GPIO_InitStruct->GPIO_OType));

        /* Output mode configuration*/
        GPIOx->OTYPER  &= ~((GPIO_OTYPER_OT_0) << ((uint16_t)pinpos)) ;
 80004b6:	686a      	ldr	r2, [r5, #4]
 80004b8:	b2a0      	uxth	r0, r4
 80004ba:	2101      	movs	r1, #1
 80004bc:	4081      	lsls	r1, r0
 80004be:	ea22 0201 	bic.w	r2, r2, r1
 80004c2:	606a      	str	r2, [r5, #4]
        GPIOx->OTYPER |= (uint16_t)(((uint16_t)GPIO_InitStruct->GPIO_OType) << ((uint16_t)pinpos));
 80004c4:	686a      	ldr	r2, [r5, #4]
 80004c6:	79b3      	ldrb	r3, [r6, #6]
 80004c8:	4083      	lsls	r3, r0
 80004ca:	b29b      	uxth	r3, r3
 80004cc:	4313      	orrs	r3, r2
 80004ce:	606b      	str	r3, [r5, #4]
      }

      /* Pull-up Pull down resistor configuration*/
      GPIOx->PUPDR &= ~(GPIO_PUPDR_PUPDR0 << ((uint16_t)pinpos * 2));
 80004d0:	68eb      	ldr	r3, [r5, #12]
 80004d2:	b2a2      	uxth	r2, r4
 80004d4:	0051      	lsls	r1, r2, #1
 80004d6:	2203      	movs	r2, #3
 80004d8:	408a      	lsls	r2, r1
 80004da:	ea23 0302 	bic.w	r3, r3, r2
 80004de:	60eb      	str	r3, [r5, #12]
      GPIOx->PUPDR |= (((uint32_t)GPIO_InitStruct->GPIO_PuPd) << (pinpos * 2));
 80004e0:	68eb      	ldr	r3, [r5, #12]
 80004e2:	79f2      	ldrb	r2, [r6, #7]
 80004e4:	fa02 f707 	lsl.w	r7, r2, r7
 80004e8:	431f      	orrs	r7, r3
 80004ea:	60ef      	str	r7, [r5, #12]
  for (pinpos = 0x00; pinpos < 0x10; pinpos++)
 80004ec:	3401      	adds	r4, #1
 80004ee:	2c0f      	cmp	r4, #15
 80004f0:	d82b      	bhi.n	800054a <GPIO_Init+0x136>
    pos = ((uint32_t)0x01) << pinpos;
 80004f2:	2301      	movs	r3, #1
 80004f4:	40a3      	lsls	r3, r4
    currentpin = (GPIO_InitStruct->GPIO_Pin) & pos;
 80004f6:	6832      	ldr	r2, [r6, #0]
    if (currentpin == pos)
 80004f8:	4393      	bics	r3, r2
 80004fa:	d1f7      	bne.n	80004ec <GPIO_Init+0xd8>
      GPIOx->MODER  &= ~(GPIO_MODER_MODER0 << (pinpos * 2));
 80004fc:	682a      	ldr	r2, [r5, #0]
 80004fe:	0067      	lsls	r7, r4, #1
 8000500:	2303      	movs	r3, #3
 8000502:	40bb      	lsls	r3, r7
 8000504:	ea6f 0803 	mvn.w	r8, r3
 8000508:	ea22 0303 	bic.w	r3, r2, r3
 800050c:	602b      	str	r3, [r5, #0]
      GPIOx->MODER |= (((uint32_t)GPIO_InitStruct->GPIO_Mode) << (pinpos * 2));
 800050e:	682b      	ldr	r3, [r5, #0]
 8000510:	7932      	ldrb	r2, [r6, #4]
 8000512:	40ba      	lsls	r2, r7
 8000514:	4313      	orrs	r3, r2
 8000516:	602b      	str	r3, [r5, #0]
      if ((GPIO_InitStruct->GPIO_Mode == GPIO_Mode_OUT) || (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_AF))
 8000518:	7933      	ldrb	r3, [r6, #4]
 800051a:	3b01      	subs	r3, #1
 800051c:	b2db      	uxtb	r3, r3
 800051e:	2b01      	cmp	r3, #1
 8000520:	d8d6      	bhi.n	80004d0 <GPIO_Init+0xbc>
        assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
 8000522:	7973      	ldrb	r3, [r6, #5]
 8000524:	2b03      	cmp	r3, #3
 8000526:	d8c1      	bhi.n	80004ac <GPIO_Init+0x98>
        GPIOx->OSPEEDR &= ~(GPIO_OSPEEDER_OSPEEDR0 << (pinpos * 2));
 8000528:	68ab      	ldr	r3, [r5, #8]
 800052a:	ea08 0303 	and.w	r3, r8, r3
 800052e:	60ab      	str	r3, [r5, #8]
        GPIOx->OSPEEDR |= ((uint32_t)(GPIO_InitStruct->GPIO_Speed) << (pinpos * 2));
 8000530:	68ab      	ldr	r3, [r5, #8]
 8000532:	7972      	ldrb	r2, [r6, #5]
 8000534:	40ba      	lsls	r2, r7
 8000536:	4313      	orrs	r3, r2
 8000538:	60ab      	str	r3, [r5, #8]
        assert_param(IS_GPIO_OTYPE(GPIO_InitStruct->GPIO_OType));
 800053a:	79b3      	ldrb	r3, [r6, #6]
 800053c:	2b01      	cmp	r3, #1
 800053e:	d9ba      	bls.n	80004b6 <GPIO_Init+0xa2>
 8000540:	21eb      	movs	r1, #235	; 0xeb
 8000542:	4804      	ldr	r0, [pc, #16]	; (8000554 <GPIO_Init+0x140>)
 8000544:	f7ff fe7e 	bl	8000244 <assert_failed>
 8000548:	e7b5      	b.n	80004b6 <GPIO_Init+0xa2>
    }
  }
}
 800054a:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 800054e:	bf00      	nop
 8000550:	40020000 	.word	0x40020000
 8000554:	080008b0 	.word	0x080008b0

08000558 <GPIO_SetBits>:
  * @param  GPIO_Pin: specifies the port bits to be written.
  *          This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
  * @retval None
  */
void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 8000558:	b538      	push	{r3, r4, r5, lr}
 800055a:	4604      	mov	r4, r0
 800055c:	460d      	mov	r5, r1
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 800055e:	4b1c      	ldr	r3, [pc, #112]	; (80005d0 <GPIO_SetBits+0x78>)
 8000560:	4298      	cmp	r0, r3
 8000562:	d02c      	beq.n	80005be <GPIO_SetBits+0x66>
 8000564:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000568:	4298      	cmp	r0, r3
 800056a:	d028      	beq.n	80005be <GPIO_SetBits+0x66>
 800056c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000570:	4298      	cmp	r0, r3
 8000572:	d024      	beq.n	80005be <GPIO_SetBits+0x66>
 8000574:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000578:	4298      	cmp	r0, r3
 800057a:	d020      	beq.n	80005be <GPIO_SetBits+0x66>
 800057c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000580:	4298      	cmp	r0, r3
 8000582:	d01c      	beq.n	80005be <GPIO_SetBits+0x66>
 8000584:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000588:	4298      	cmp	r0, r3
 800058a:	d018      	beq.n	80005be <GPIO_SetBits+0x66>
 800058c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000590:	4298      	cmp	r0, r3
 8000592:	d014      	beq.n	80005be <GPIO_SetBits+0x66>
 8000594:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000598:	4298      	cmp	r0, r3
 800059a:	d010      	beq.n	80005be <GPIO_SetBits+0x66>
 800059c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005a0:	4298      	cmp	r0, r3
 80005a2:	d00c      	beq.n	80005be <GPIO_SetBits+0x66>
 80005a4:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005a8:	4298      	cmp	r0, r3
 80005aa:	d008      	beq.n	80005be <GPIO_SetBits+0x66>
 80005ac:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005b0:	4298      	cmp	r0, r3
 80005b2:	d004      	beq.n	80005be <GPIO_SetBits+0x66>
 80005b4:	f240 119f 	movw	r1, #415	; 0x19f
 80005b8:	4806      	ldr	r0, [pc, #24]	; (80005d4 <GPIO_SetBits+0x7c>)
 80005ba:	f7ff fe43 	bl	8000244 <assert_failed>
  assert_param(IS_GPIO_PIN(GPIO_Pin));
 80005be:	b10d      	cbz	r5, 80005c4 <GPIO_SetBits+0x6c>

  GPIOx->BSRRL = GPIO_Pin;
 80005c0:	8325      	strh	r5, [r4, #24]
}
 80005c2:	bd38      	pop	{r3, r4, r5, pc}
  assert_param(IS_GPIO_PIN(GPIO_Pin));
 80005c4:	f44f 71d0 	mov.w	r1, #416	; 0x1a0
 80005c8:	4802      	ldr	r0, [pc, #8]	; (80005d4 <GPIO_SetBits+0x7c>)
 80005ca:	f7ff fe3b 	bl	8000244 <assert_failed>
 80005ce:	e7f7      	b.n	80005c0 <GPIO_SetBits+0x68>
 80005d0:	40020000 	.word	0x40020000
 80005d4:	080008b0 	.word	0x080008b0

080005d8 <GPIO_ResetBits>:
  * @param  GPIO_Pin: specifies the port bits to be written.
  *          This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
  * @retval None
  */
void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 80005d8:	b538      	push	{r3, r4, r5, lr}
 80005da:	4604      	mov	r4, r0
 80005dc:	460d      	mov	r5, r1
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
 80005de:	4b1c      	ldr	r3, [pc, #112]	; (8000650 <GPIO_ResetBits+0x78>)
 80005e0:	4298      	cmp	r0, r3
 80005e2:	d02c      	beq.n	800063e <GPIO_ResetBits+0x66>
 80005e4:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005e8:	4298      	cmp	r0, r3
 80005ea:	d028      	beq.n	800063e <GPIO_ResetBits+0x66>
 80005ec:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005f0:	4298      	cmp	r0, r3
 80005f2:	d024      	beq.n	800063e <GPIO_ResetBits+0x66>
 80005f4:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 80005f8:	4298      	cmp	r0, r3
 80005fa:	d020      	beq.n	800063e <GPIO_ResetBits+0x66>
 80005fc:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000600:	4298      	cmp	r0, r3
 8000602:	d01c      	beq.n	800063e <GPIO_ResetBits+0x66>
 8000604:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000608:	4298      	cmp	r0, r3
 800060a:	d018      	beq.n	800063e <GPIO_ResetBits+0x66>
 800060c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000610:	4298      	cmp	r0, r3
 8000612:	d014      	beq.n	800063e <GPIO_ResetBits+0x66>
 8000614:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000618:	4298      	cmp	r0, r3
 800061a:	d010      	beq.n	800063e <GPIO_ResetBits+0x66>
 800061c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000620:	4298      	cmp	r0, r3
 8000622:	d00c      	beq.n	800063e <GPIO_ResetBits+0x66>
 8000624:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000628:	4298      	cmp	r0, r3
 800062a:	d008      	beq.n	800063e <GPIO_ResetBits+0x66>
 800062c:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8000630:	4298      	cmp	r0, r3
 8000632:	d004      	beq.n	800063e <GPIO_ResetBits+0x66>
 8000634:	f44f 71da 	mov.w	r1, #436	; 0x1b4
 8000638:	4806      	ldr	r0, [pc, #24]	; (8000654 <GPIO_ResetBits+0x7c>)
 800063a:	f7ff fe03 	bl	8000244 <assert_failed>
  assert_param(IS_GPIO_PIN(GPIO_Pin));
 800063e:	b10d      	cbz	r5, 8000644 <GPIO_ResetBits+0x6c>

  GPIOx->BSRRH = GPIO_Pin;
 8000640:	8365      	strh	r5, [r4, #26]
}
 8000642:	bd38      	pop	{r3, r4, r5, pc}
  assert_param(IS_GPIO_PIN(GPIO_Pin));
 8000644:	f240 11b5 	movw	r1, #437	; 0x1b5
 8000648:	4802      	ldr	r0, [pc, #8]	; (8000654 <GPIO_ResetBits+0x7c>)
 800064a:	f7ff fdfb 	bl	8000244 <assert_failed>
 800064e:	e7f7      	b.n	8000640 <GPIO_ResetBits+0x68>
 8000650:	40020000 	.word	0x40020000
 8000654:	080008b0 	.word	0x080008b0

08000658 <RCC_HSEConfig>:
  *            @arg RCC_HSE_ON: turn ON the HSE oscillator
  *            @arg RCC_HSE_Bypass: HSE oscillator bypassed with external clock
  * @retval None
  */
void RCC_HSEConfig(uint8_t RCC_HSE)
{
 8000658:	b510      	push	{r4, lr}
 800065a:	4604      	mov	r4, r0
  /* Check the parameters */
  assert_param(IS_RCC_HSE(RCC_HSE));
 800065c:	2801      	cmp	r0, #1
 800065e:	d901      	bls.n	8000664 <RCC_HSEConfig+0xc>
 8000660:	2805      	cmp	r0, #5
 8000662:	d104      	bne.n	800066e <RCC_HSEConfig+0x16>

  /* Reset HSEON and HSEBYP bits before configuring the HSE ------------------*/
  *(__IO uint8_t *) CR_BYTE3_ADDRESS = RCC_HSE_OFF;
 8000664:	4b05      	ldr	r3, [pc, #20]	; (800067c <RCC_HSEConfig+0x24>)
 8000666:	2200      	movs	r2, #0
 8000668:	709a      	strb	r2, [r3, #2]

  /* Set the new HSE configuration -------------------------------------------*/
  *(__IO uint8_t *) CR_BYTE3_ADDRESS = RCC_HSE;
 800066a:	709c      	strb	r4, [r3, #2]
}
 800066c:	bd10      	pop	{r4, pc}
  assert_param(IS_RCC_HSE(RCC_HSE));
 800066e:	f240 111f 	movw	r1, #287	; 0x11f
 8000672:	4803      	ldr	r0, [pc, #12]	; (8000680 <RCC_HSEConfig+0x28>)
 8000674:	f7ff fde6 	bl	8000244 <assert_failed>
 8000678:	e7f4      	b.n	8000664 <RCC_HSEConfig+0xc>
 800067a:	bf00      	nop
 800067c:	40023800 	.word	0x40023800
 8000680:	080008f0 	.word	0x080008f0

08000684 <RCC_PLLCmd>:
  * @note   The main PLL is disabled by hardware when entering STOP and STANDBY modes.
  * @param  NewState: new state of the main PLL. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_PLLCmd(FunctionalState NewState)
{
 8000684:	b510      	push	{r4, lr}
 8000686:	4604      	mov	r4, r0
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
 8000688:	2801      	cmp	r0, #1
 800068a:	d802      	bhi.n	8000692 <RCC_PLLCmd+0xe>
  *(__IO uint32_t *) CR_PLLON_BB = (uint32_t)NewState;
 800068c:	4b04      	ldr	r3, [pc, #16]	; (80006a0 <RCC_PLLCmd+0x1c>)
 800068e:	661c      	str	r4, [r3, #96]	; 0x60
}
 8000690:	bd10      	pop	{r4, pc}
  assert_param(IS_FUNCTIONAL_STATE(NewState));
 8000692:	f240 2136 	movw	r1, #566	; 0x236
 8000696:	4803      	ldr	r0, [pc, #12]	; (80006a4 <RCC_PLLCmd+0x20>)
 8000698:	f7ff fdd4 	bl	8000244 <assert_failed>
 800069c:	e7f6      	b.n	800068c <RCC_PLLCmd+0x8>
 800069e:	bf00      	nop
 80006a0:	42470000 	.word	0x42470000
 80006a4:	080008f0 	.word	0x080008f0

080006a8 <RCC_SYSCLKConfig>:
  *            @arg RCC_SYSCLKSource_PLLCLK: PLL selected as system clock source (RCC_SYSCLKSource_PLLPCLK for STM32F446xx devices)
  *            @arg RCC_SYSCLKSource_PLLRCLK: PLL R selected as system clock source only for STM32F412xG, STM32F413_423xx and STM32F446xx devices
  * @retval None
  */
void RCC_SYSCLKConfig(uint32_t RCC_SYSCLKSource)
{
 80006a8:	b510      	push	{r4, lr}
 80006aa:	4604      	mov	r4, r0
  uint32_t tmpreg = 0;

  /* Check the parameters */
  assert_param(IS_RCC_SYSCLK_SOURCE(RCC_SYSCLKSource));
 80006ac:	2802      	cmp	r0, #2
 80006ae:	d806      	bhi.n	80006be <RCC_SYSCLKConfig+0x16>

  tmpreg = RCC->CFGR;
 80006b0:	4b06      	ldr	r3, [pc, #24]	; (80006cc <RCC_SYSCLKConfig+0x24>)
 80006b2:	6898      	ldr	r0, [r3, #8]

  /* Clear SW[1:0] bits */
  tmpreg &= ~RCC_CFGR_SW;
 80006b4:	f020 0003 	bic.w	r0, r0, #3

  /* Set SW[1:0] bits according to RCC_SYSCLKSource value */
  tmpreg |= RCC_SYSCLKSource;
 80006b8:	4304      	orrs	r4, r0

  /* Store the new value */
  RCC->CFGR = tmpreg;
 80006ba:	609c      	str	r4, [r3, #8]
}
 80006bc:	bd10      	pop	{r4, pc}
  assert_param(IS_RCC_SYSCLK_SOURCE(RCC_SYSCLKSource));
 80006be:	f240 4182 	movw	r1, #1154	; 0x482
 80006c2:	4803      	ldr	r0, [pc, #12]	; (80006d0 <RCC_SYSCLKConfig+0x28>)
 80006c4:	f7ff fdbe 	bl	8000244 <assert_failed>
 80006c8:	e7f2      	b.n	80006b0 <RCC_SYSCLKConfig+0x8>
 80006ca:	bf00      	nop
 80006cc:	40023800 	.word	0x40023800
 80006d0:	080008f0 	.word	0x080008f0

080006d4 <RCC_AHB1PeriphClockCmd>:
  * @param  NewState: new state of the specified peripheral clock.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_AHB1PeriphClockCmd(uint32_t RCC_AHB1Periph, FunctionalState NewState)
{
 80006d4:	b538      	push	{r3, r4, r5, lr}
 80006d6:	4604      	mov	r4, r0
 80006d8:	460d      	mov	r5, r1
  /* Check the parameters */
  assert_param(IS_RCC_AHB1_CLOCK_PERIPH(RCC_AHB1Periph));
 80006da:	4b0e      	ldr	r3, [pc, #56]	; (8000714 <RCC_AHB1PeriphClockCmd+0x40>)
 80006dc:	4218      	tst	r0, r3
 80006de:	d100      	bne.n	80006e2 <RCC_AHB1PeriphClockCmd+0xe>
 80006e0:	b920      	cbnz	r0, 80006ec <RCC_AHB1PeriphClockCmd+0x18>
 80006e2:	f640 013b 	movw	r1, #2107	; 0x83b
 80006e6:	480c      	ldr	r0, [pc, #48]	; (8000718 <RCC_AHB1PeriphClockCmd+0x44>)
 80006e8:	f7ff fdac 	bl	8000244 <assert_failed>

  assert_param(IS_FUNCTIONAL_STATE(NewState));
 80006ec:	2d01      	cmp	r5, #1
 80006ee:	d805      	bhi.n	80006fc <RCC_AHB1PeriphClockCmd+0x28>
  if (NewState != DISABLE)
 80006f0:	b155      	cbz	r5, 8000708 <RCC_AHB1PeriphClockCmd+0x34>
  {
    RCC->AHB1ENR |= RCC_AHB1Periph;
 80006f2:	4b0a      	ldr	r3, [pc, #40]	; (800071c <RCC_AHB1PeriphClockCmd+0x48>)
 80006f4:	6b18      	ldr	r0, [r3, #48]	; 0x30
 80006f6:	4304      	orrs	r4, r0
 80006f8:	631c      	str	r4, [r3, #48]	; 0x30
  }
  else
  {
    RCC->AHB1ENR &= ~RCC_AHB1Periph;
  }
}
 80006fa:	bd38      	pop	{r3, r4, r5, pc}
  assert_param(IS_FUNCTIONAL_STATE(NewState));
 80006fc:	f640 013d 	movw	r1, #2109	; 0x83d
 8000700:	4805      	ldr	r0, [pc, #20]	; (8000718 <RCC_AHB1PeriphClockCmd+0x44>)
 8000702:	f7ff fd9f 	bl	8000244 <assert_failed>
 8000706:	e7f3      	b.n	80006f0 <RCC_AHB1PeriphClockCmd+0x1c>
    RCC->AHB1ENR &= ~RCC_AHB1Periph;
 8000708:	4b04      	ldr	r3, [pc, #16]	; (800071c <RCC_AHB1PeriphClockCmd+0x48>)
 800070a:	6b18      	ldr	r0, [r3, #48]	; 0x30
 800070c:	ea20 0404 	bic.w	r4, r0, r4
 8000710:	631c      	str	r4, [r3, #48]	; 0x30
}
 8000712:	e7f2      	b.n	80006fa <RCC_AHB1PeriphClockCmd+0x26>
 8000714:	010be800 	.word	0x010be800
 8000718:	080008f0 	.word	0x080008f0
 800071c:	40023800 	.word	0x40023800

08000720 <RCC_ITConfig>:
  * @param  NewState: new state of the specified RCC interrupts.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_ITConfig(uint8_t RCC_IT, FunctionalState NewState)
{
 8000720:	b538      	push	{r3, r4, r5, lr}
 8000722:	4604      	mov	r4, r0
 8000724:	460d      	mov	r5, r1
  /* Check the parameters */
  assert_param(IS_RCC_IT(RCC_IT));
 8000726:	b243      	sxtb	r3, r0
 8000728:	2b00      	cmp	r3, #0
 800072a:	dd07      	ble.n	800073c <RCC_ITConfig+0x1c>
  assert_param(IS_FUNCTIONAL_STATE(NewState));
 800072c:	2d01      	cmp	r5, #1
 800072e:	d80b      	bhi.n	8000748 <RCC_ITConfig+0x28>
  if (NewState != DISABLE)
 8000730:	b185      	cbz	r5, 8000754 <RCC_ITConfig+0x34>
  {
    /* Perform Byte access to RCC_CIR[14:8] bits to enable the selected interrupts */
    *(__IO uint8_t *) CIR_BYTE2_ADDRESS |= RCC_IT;
 8000732:	4b0b      	ldr	r3, [pc, #44]	; (8000760 <RCC_ITConfig+0x40>)
 8000734:	7b58      	ldrb	r0, [r3, #13]
 8000736:	4304      	orrs	r4, r0
 8000738:	735c      	strb	r4, [r3, #13]
  else
  {
    /* Perform Byte access to RCC_CIR[14:8] bits to disable the selected interrupts */
    *(__IO uint8_t *) CIR_BYTE2_ADDRESS &= (uint8_t)~RCC_IT;
  }
}
 800073a:	bd38      	pop	{r3, r4, r5, pc}
  assert_param(IS_RCC_IT(RCC_IT));
 800073c:	f640 31d9 	movw	r1, #3033	; 0xbd9
 8000740:	4808      	ldr	r0, [pc, #32]	; (8000764 <RCC_ITConfig+0x44>)
 8000742:	f7ff fd7f 	bl	8000244 <assert_failed>
 8000746:	e7f1      	b.n	800072c <RCC_ITConfig+0xc>
  assert_param(IS_FUNCTIONAL_STATE(NewState));
 8000748:	f640 31da 	movw	r1, #3034	; 0xbda
 800074c:	4805      	ldr	r0, [pc, #20]	; (8000764 <RCC_ITConfig+0x44>)
 800074e:	f7ff fd79 	bl	8000244 <assert_failed>
 8000752:	e7ed      	b.n	8000730 <RCC_ITConfig+0x10>
    *(__IO uint8_t *) CIR_BYTE2_ADDRESS &= (uint8_t)~RCC_IT;
 8000754:	4b02      	ldr	r3, [pc, #8]	; (8000760 <RCC_ITConfig+0x40>)
 8000756:	7b58      	ldrb	r0, [r3, #13]
 8000758:	ea20 0404 	bic.w	r4, r0, r4
 800075c:	735c      	strb	r4, [r3, #13]
}
 800075e:	e7ec      	b.n	800073a <RCC_ITConfig+0x1a>
 8000760:	40023800 	.word	0x40023800
 8000764:	080008f0 	.word	0x080008f0

08000768 <RCC_GetFlagStatus>:
  *            @arg RCC_FLAG_WWDGRST: Window Watchdog reset
  *            @arg RCC_FLAG_LPWRRST: Low Power reset
  * @retval The new state of RCC_FLAG (SET or RESET).
  */
FlagStatus RCC_GetFlagStatus(uint8_t RCC_FLAG)
{
 8000768:	b510      	push	{r4, lr}
 800076a:	4604      	mov	r4, r0
  uint32_t tmp = 0;
  uint32_t statusreg = 0;
  FlagStatus bitstatus = RESET;

  /* Check the parameters */
  assert_param(IS_RCC_FLAG(RCC_FLAG));
 800076c:	2821      	cmp	r0, #33	; 0x21
 800076e:	d019      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000770:	2831      	cmp	r0, #49	; 0x31
 8000772:	d017      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000774:	2839      	cmp	r0, #57	; 0x39
 8000776:	d015      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000778:	2841      	cmp	r0, #65	; 0x41
 800077a:	d013      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 800077c:	2861      	cmp	r0, #97	; 0x61
 800077e:	d011      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000780:	2879      	cmp	r0, #121	; 0x79
 8000782:	d00f      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000784:	287a      	cmp	r0, #122	; 0x7a
 8000786:	d00d      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000788:	287b      	cmp	r0, #123	; 0x7b
 800078a:	d00b      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 800078c:	287c      	cmp	r0, #124	; 0x7c
 800078e:	d009      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000790:	287d      	cmp	r0, #125	; 0x7d
 8000792:	d007      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000794:	287e      	cmp	r0, #126	; 0x7e
 8000796:	d005      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 8000798:	287f      	cmp	r0, #127	; 0x7f
 800079a:	d003      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 800079c:	283b      	cmp	r0, #59	; 0x3b
 800079e:	d001      	beq.n	80007a4 <RCC_GetFlagStatus+0x3c>
 80007a0:	283d      	cmp	r0, #61	; 0x3d
 80007a2:	d10f      	bne.n	80007c4 <RCC_GetFlagStatus+0x5c>

  /* Get the RCC register index */
  tmp = RCC_FLAG >> 5;
 80007a4:	0963      	lsrs	r3, r4, #5
  if (tmp == 1)               /* The flag to check is in CR register */
 80007a6:	2b01      	cmp	r3, #1
 80007a8:	d012      	beq.n	80007d0 <RCC_GetFlagStatus+0x68>
  {
    statusreg = RCC->CR;
  }
  else if (tmp == 2)          /* The flag to check is in BDCR register */
 80007aa:	2b02      	cmp	r3, #2
 80007ac:	d013      	beq.n	80007d6 <RCC_GetFlagStatus+0x6e>
  {
    statusreg = RCC->BDCR;
  }
  else                       /* The flag to check is in CSR register */
  {
    statusreg = RCC->CSR;
 80007ae:	4b0c      	ldr	r3, [pc, #48]	; (80007e0 <RCC_GetFlagStatus+0x78>)
 80007b0:	6f58      	ldr	r0, [r3, #116]	; 0x74
  }

  /* Get the flag position */
  tmp = RCC_FLAG & FLAG_MASK;
 80007b2:	f004 041f 	and.w	r4, r4, #31
  if ((statusreg & ((uint32_t)1 << tmp)) != (uint32_t)RESET)
 80007b6:	fa20 f404 	lsr.w	r4, r0, r4
 80007ba:	f014 0f01 	tst.w	r4, #1
 80007be:	d00d      	beq.n	80007dc <RCC_GetFlagStatus+0x74>
  {
    bitstatus = SET;
 80007c0:	2001      	movs	r0, #1
  {
    bitstatus = RESET;
  }
  /* Return the flag status */
  return bitstatus;
}
 80007c2:	bd10      	pop	{r4, pc}
  assert_param(IS_RCC_FLAG(RCC_FLAG));
 80007c4:	f640 4102 	movw	r1, #3074	; 0xc02
 80007c8:	4806      	ldr	r0, [pc, #24]	; (80007e4 <RCC_GetFlagStatus+0x7c>)
 80007ca:	f7ff fd3b 	bl	8000244 <assert_failed>
 80007ce:	e7e9      	b.n	80007a4 <RCC_GetFlagStatus+0x3c>
    statusreg = RCC->CR;
 80007d0:	4b03      	ldr	r3, [pc, #12]	; (80007e0 <RCC_GetFlagStatus+0x78>)
 80007d2:	6818      	ldr	r0, [r3, #0]
 80007d4:	e7ed      	b.n	80007b2 <RCC_GetFlagStatus+0x4a>
    statusreg = RCC->BDCR;
 80007d6:	4b02      	ldr	r3, [pc, #8]	; (80007e0 <RCC_GetFlagStatus+0x78>)
 80007d8:	6f18      	ldr	r0, [r3, #112]	; 0x70
 80007da:	e7ea      	b.n	80007b2 <RCC_GetFlagStatus+0x4a>
    bitstatus = RESET;
 80007dc:	2000      	movs	r0, #0
 80007de:	e7f0      	b.n	80007c2 <RCC_GetFlagStatus+0x5a>
 80007e0:	40023800 	.word	0x40023800
 80007e4:	080008f0 	.word	0x080008f0

080007e8 <RCC_GetITStatus>:
  *            @arg RCC_IT_PLLSAIRDY: PLLSAI clock ready interrupt (only for STM32F42xxx/43xxx/446xx/469xx/479xx devices)
  *            @arg RCC_IT_CSS: Clock Security System interrupt
  * @retval The new state of RCC_IT (SET or RESET).
  */
ITStatus RCC_GetITStatus(uint8_t RCC_IT)
{
 80007e8:	b510      	push	{r4, lr}
 80007ea:	4604      	mov	r4, r0
  ITStatus bitstatus = RESET;

  /* Check the parameters */
  assert_param(IS_RCC_GET_IT(RCC_IT));
 80007ec:	1e43      	subs	r3, r0, #1
 80007ee:	b2db      	uxtb	r3, r3
 80007f0:	2b01      	cmp	r3, #1
 80007f2:	d90b      	bls.n	800080c <RCC_GetITStatus+0x24>
 80007f4:	2804      	cmp	r0, #4
 80007f6:	d009      	beq.n	800080c <RCC_GetITStatus+0x24>
 80007f8:	2808      	cmp	r0, #8
 80007fa:	d007      	beq.n	800080c <RCC_GetITStatus+0x24>
 80007fc:	2810      	cmp	r0, #16
 80007fe:	d005      	beq.n	800080c <RCC_GetITStatus+0x24>
 8000800:	2880      	cmp	r0, #128	; 0x80
 8000802:	d003      	beq.n	800080c <RCC_GetITStatus+0x24>
 8000804:	2840      	cmp	r0, #64	; 0x40
 8000806:	d001      	beq.n	800080c <RCC_GetITStatus+0x24>
 8000808:	2820      	cmp	r0, #32
 800080a:	d105      	bne.n	8000818 <RCC_GetITStatus+0x30>

  /* Check the status of the specified RCC interrupt */
  if ((RCC->CIR & RCC_IT) != (uint32_t)RESET)
 800080c:	4b06      	ldr	r3, [pc, #24]	; (8000828 <RCC_GetITStatus+0x40>)
 800080e:	68db      	ldr	r3, [r3, #12]
 8000810:	421c      	tst	r4, r3
 8000812:	d007      	beq.n	8000824 <RCC_GetITStatus+0x3c>
  {
    bitstatus = SET;
 8000814:	2001      	movs	r0, #1
  {
    bitstatus = RESET;
  }
  /* Return the RCC_IT status */
  return  bitstatus;
}
 8000816:	bd10      	pop	{r4, pc}
  assert_param(IS_RCC_GET_IT(RCC_IT));
 8000818:	f640 4141 	movw	r1, #3137	; 0xc41
 800081c:	4803      	ldr	r0, [pc, #12]	; (800082c <RCC_GetITStatus+0x44>)
 800081e:	f7ff fd11 	bl	8000244 <assert_failed>
 8000822:	e7f3      	b.n	800080c <RCC_GetITStatus+0x24>
    bitstatus = RESET;
 8000824:	2000      	movs	r0, #0
 8000826:	e7f6      	b.n	8000816 <RCC_GetITStatus+0x2e>
 8000828:	40023800 	.word	0x40023800
 800082c:	080008f0 	.word	0x080008f0

08000830 <RCC_ClearITPendingBit>:
  *            @arg RCC_IT_PLLSAIRDY: PLLSAI ready interrupt (only for STM32F42xxx/43xxx/446xx/469xx/479xx devices) 
  *            @arg RCC_IT_CSS: Clock Security System interrupt
  * @retval None
  */
void RCC_ClearITPendingBit(uint8_t RCC_IT)
{
 8000830:	b510      	push	{r4, lr}
  /* Check the parameters */
  assert_param(IS_RCC_CLEAR_IT(RCC_IT));
 8000832:	4604      	mov	r4, r0
 8000834:	b110      	cbz	r0, 800083c <RCC_ClearITPendingBit+0xc>

  /* Perform Byte access to RCC_CIR[23:16] bits to clear the selected interrupt
     pending bits */
  *(__IO uint8_t *) CIR_BYTE3_ADDRESS = RCC_IT;
 8000836:	4b04      	ldr	r3, [pc, #16]	; (8000848 <RCC_ClearITPendingBit+0x18>)
 8000838:	739c      	strb	r4, [r3, #14]
}
 800083a:	bd10      	pop	{r4, pc}
  assert_param(IS_RCC_CLEAR_IT(RCC_IT));
 800083c:	f640 4161 	movw	r1, #3169	; 0xc61
 8000840:	4802      	ldr	r0, [pc, #8]	; (800084c <RCC_ClearITPendingBit+0x1c>)
 8000842:	f7ff fcff 	bl	8000244 <assert_failed>
 8000846:	e7f6      	b.n	8000836 <RCC_ClearITPendingBit+0x6>
 8000848:	40023800 	.word	0x40023800
 800084c:	080008f0 	.word	0x080008f0

08000850 <__libc_init_array>:
 8000850:	b570      	push	{r4, r5, r6, lr}
 8000852:	4d0d      	ldr	r5, [pc, #52]	; (8000888 <__libc_init_array+0x38>)
 8000854:	4c0d      	ldr	r4, [pc, #52]	; (800088c <__libc_init_array+0x3c>)
 8000856:	1b64      	subs	r4, r4, r5
 8000858:	10a4      	asrs	r4, r4, #2
 800085a:	2600      	movs	r6, #0
 800085c:	42a6      	cmp	r6, r4
 800085e:	d109      	bne.n	8000874 <__libc_init_array+0x24>
 8000860:	4d0b      	ldr	r5, [pc, #44]	; (8000890 <__libc_init_array+0x40>)
 8000862:	4c0c      	ldr	r4, [pc, #48]	; (8000894 <__libc_init_array+0x44>)
 8000864:	f000 f818 	bl	8000898 <_init>
 8000868:	1b64      	subs	r4, r4, r5
 800086a:	10a4      	asrs	r4, r4, #2
 800086c:	2600      	movs	r6, #0
 800086e:	42a6      	cmp	r6, r4
 8000870:	d105      	bne.n	800087e <__libc_init_array+0x2e>
 8000872:	bd70      	pop	{r4, r5, r6, pc}
 8000874:	f855 3b04 	ldr.w	r3, [r5], #4
 8000878:	4798      	blx	r3
 800087a:	3601      	adds	r6, #1
 800087c:	e7ee      	b.n	800085c <__libc_init_array+0xc>
 800087e:	f855 3b04 	ldr.w	r3, [r5], #4
 8000882:	4798      	blx	r3
 8000884:	3601      	adds	r6, #1
 8000886:	e7f2      	b.n	800086e <__libc_init_array+0x1e>
 8000888:	0800092c 	.word	0x0800092c
 800088c:	0800092c 	.word	0x0800092c
 8000890:	0800092c 	.word	0x0800092c
 8000894:	08000930 	.word	0x08000930

08000898 <_init>:
 8000898:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 800089a:	bf00      	nop
 800089c:	bcf8      	pop	{r3, r4, r5, r6, r7}
 800089e:	bc08      	pop	{r3}
 80008a0:	469e      	mov	lr, r3
 80008a2:	4770      	bx	lr

080008a4 <_fini>:
 80008a4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 80008a6:	bf00      	nop
 80008a8:	bcf8      	pop	{r3, r4, r5, r6, r7}
 80008aa:	bc08      	pop	{r3}
 80008ac:	469e      	mov	lr, r3
 80008ae:	4770      	bx	lr
