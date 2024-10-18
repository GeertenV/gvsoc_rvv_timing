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

VLEN1  		= 16
VLEN2  		= 8
ADDRESS1		= 0x10
ADDRESS2		= 0x10000000

	li				a2,6*VLEN1

# fill memory with values #
	li				a0,0					
	li				a1,ADDRESS1				
.L1:
	fcvt.s.w		fa0,a0					
	addi			a0,a0,1					
	fsw				fa0,(a1)				
	addi			a1,a1,4					
	bne				a2,a0,.L1

# fill memory2 with values #
	li				a0,0					
	li				a1,ADDRESS2				
.L2:
	fcvt.s.w		fa0,a0					
	addi			a0,a0,1					
	fsw				fa0,(a1)				
	addi			a1,a1,4					
	bne				a2,a0,.L2

	nop
	nop
	nop
	nop

# VLEN1 + ADDRESS1 #
	# set vector length and element width #
	li				a0,VLEN1				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	li				a2,4*VLEN1

	# load 2 vectors and add them #
	li				a1,ADDRESS1
	vle32.v 		v1,(a1)
	add				a1,a1,a2		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v3,(a1)	
	add				a1,a1,a2		
	vle32.v 		v4,(a1)
	vfadd.vv		v3,v4,v3

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v5,(a1)
	add				a1,a1,a2		
	vle32.v 		v6,(a1)
	vfadd.vv		v5,v6,v5

	# write back 3 vectors #
	li				a1,ADDRESS1
	vse32.v			v1,(a1)
	add				a1,a1,a2
	vse32.v			v3,(a1)
	add				a1,a1,a2
	vse32.v			v5,(a1)

	nop
	nop
	nop
	nop

# VLEN2 + ADDRESS1 #
	# set vector length and element width #
	li				a0,VLEN2				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	li				a2,4*VLEN2

	# load 2 vectors and add them #
	li				a1,ADDRESS1
	vle32.v 		v1,(a1)
	add				a1,a1,a2		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v3,(a1)	
	add				a1,a1,a2		
	vle32.v 		v4,(a1)
	vfadd.vv		v3,v4,v3

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v5,(a1)
	add				a1,a1,a2		
	vle32.v 		v6,(a1)
	vfadd.vv		v5,v6,v5

	# write back 3 vectors #
	li				a1,ADDRESS1
	vse32.v			v1,(a1)
	add				a1,a1,a2
	vse32.v			v3,(a1)
	add				a1,a1,a2
	vse32.v			v5,(a1)

	nop
	nop
	nop
	nop

# VLEN1 + ADDRESS2 #
	# set vector length and element width #
	li				a0,VLEN1				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	li				a2,4*VLEN1

	# load 2 vectors and add them #
	li				a1,ADDRESS2
	vle32.v 		v1,(a1)
	add				a1,a1,a2		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v3,(a1)	
	add				a1,a1,a2		
	vle32.v 		v4,(a1)
	vfadd.vv		v3,v4,v3

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v5,(a1)
	add				a1,a1,a2		
	vle32.v 		v6,(a1)
	vfadd.vv		v5,v6,v5

	# write back 3 vectors #
	li				a1,ADDRESS2
	vse32.v			v1,(a1)
	add				a1,a1,a2
	vse32.v			v3,(a1)
	add				a1,a1,a2
	vse32.v			v5,(a1)

	nop
	nop
	nop
	nop

# VLEN2 + ADDRESS2 #
	# set vector length and element width #
	li				a0,VLEN2				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	li				a2,4*VLEN2

	# load 2 vectors and add them #
	li				a1,ADDRESS2
	vle32.v 		v1,(a1)
	add				a1,a1,a2		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v3,(a1)	
	add				a1,a1,a2		
	vle32.v 		v4,(a1)
	vfadd.vv		v3,v4,v3

	# load 2 vectors and add them #
	add				a1,a1,a2		
	vle32.v 		v5,(a1)
	add				a1,a1,a2		
	vle32.v 		v6,(a1)
	vfadd.vv		v5,v6,v5

	# write back 3 vectors #
	li				a1,ADDRESS2
	vse32.v			v1,(a1)
	add				a1,a1,a2
	vse32.v			v3,(a1)
	add				a1,a1,a2
	vse32.v			v5,(a1)

	nop
	nop
	nop
	nop


	li	a5,0
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
