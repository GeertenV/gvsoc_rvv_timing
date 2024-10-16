	.option nopic
	.attribute arch, "rv32i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16

VLEN  		= 16
ADDRESS		= 12345

	li				a2,6*VLEN

# fill memory with values #
	li				a0,0					
	li				a1,ADDRESS				
.L1:
	fcvt.s.w		fa0,a0					
	addi			a0,a0,1					
	fsw				fa0,(a1)				
	addi			a1,a1,4					
	bne				a2,a0,.L1

# set vector length and element width #
	li				a0,VLEN				
	vsetvli 		t0,a0,e32			

	li				a1,ADDRESS
	vle32.v 		v1,(a1)
	li				a2,4*VLEN
	add				a1,a1,a2		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	add				a1,a1,a2		
	vle32.v 		v3,(a1)	
	add				a1,a1,a2		
	vle32.v 		v4,(a1)
	vfadd.vv		v3,v4,v3

	add				a1,a1,a2		
	vle32.v 		v5,(a1)
	add				a1,a1,a2		
	vle32.v 		v6,(a1)
	vfadd.vv		v5,v6,v5

	li				a1,0
	vse32.v			v1,(a1)
	add				a1,a1,a2
	vse32.v			v3,(a1)
	add				a1,a1,a2
	vse32.v			v5,(a1)

	li	a5,0
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
