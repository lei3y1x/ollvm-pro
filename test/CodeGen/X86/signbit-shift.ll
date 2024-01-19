; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s

; If positive...

define i32 @zext_ifpos(i32 %x) {
; CHECK-LABEL: zext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    notl %eax
; CHECK-NEXT:    shrl $31, %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  ret i32 %e
}

define i32 @add_zext_ifpos(i32 %x) {
; CHECK-LABEL: add_zext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define <4 x i32> @add_zext_ifpos_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_zext_ifpos_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm1, %xmm0
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-NEXT:    psubd %xmm0, %xmm1
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %c = icmp sgt <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = zext <4 x i1> %c to <4 x i32>
  %r = add <4 x i32> %e, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define i32 @sel_ifpos_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_tval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifpos(i32 %x) {
; CHECK-LABEL: sext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    notl %eax
; CHECK-NEXT:    sarl $31, %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  ret i32 %e
}

define i32 @add_sext_ifpos(i32 %x) {
; CHECK-LABEL: add_sext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shrl $31, %edi
; CHECK-NEXT:    leal 41(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define <4 x i32> @add_sext_ifpos_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_sext_ifpos_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm1, %xmm0
; CHECK-NEXT:    paddd {{.*}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %c = icmp sgt <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = sext <4 x i1> %c to <4 x i32>
  %r = add <4 x i32> %e, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define i32 @sel_ifpos_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_fval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shrl $31, %edi
; CHECK-NEXT:    leal 41(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}

; If negative...

define i32 @zext_ifneg(i32 %x) {
; CHECK-LABEL: zext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shrl $31, %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %r = zext i1 %c to i32
  ret i32 %r
}

define i32 @add_zext_ifneg(i32 %x) {
; CHECK-LABEL: add_zext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shrl $31, %edi
; CHECK-NEXT:    leal 41(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define i32 @sel_ifneg_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_tval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shrl $31, %edi
; CHECK-NEXT:    leal 41(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifneg(i32 %x) {
; CHECK-LABEL: sext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    sarl $31, %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %r = sext i1 %c to i32
  ret i32 %r
}

define i32 @add_sext_ifneg(i32 %x) {
; CHECK-LABEL: add_sext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define i32 @sel_ifneg_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_fval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}

define i32 @add_lshr_not(i32 %x) {
; CHECK-LABEL: add_lshr_not:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %not = xor i32 %x, -1
  %sh = lshr i32 %not, 31
  %r = add i32 %sh, 41
  ret i32 %r
}

define <4 x i32> @add_lshr_not_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_lshr_not_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    psrad $31, %xmm0
; CHECK-NEXT:    paddd {{.*}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %c = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = lshr <4 x i32> %c, <i32 31, i32 31, i32 31, i32 31>
  %r = add <4 x i32> %e, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define i32 @sub_lshr_not(i32 %x) {
; CHECK-LABEL: sub_lshr_not:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    shrl $31, %edi
; CHECK-NEXT:    leal 42(%rdi), %eax
; CHECK-NEXT:    retq
  %not = xor i32 %x, -1
  %sh = lshr i32 %not, 31
  %r = sub i32 43, %sh
  ret i32 %r
}

define <4 x i32> @sub_lshr_not_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: sub_lshr_not_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    psrld $31, %xmm0
; CHECK-NEXT:    paddd {{.*}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %c = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = lshr <4 x i32> %c, <i32 31, i32 31, i32 31, i32 31>
  %r = sub <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %e
  ret <4 x i32> %r
}

define i32 @sub_lshr(i32 %x, i32 %y) {
; CHECK-LABEL: sub_lshr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $esi killed $esi def $rsi
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal (%rdi,%rsi), %eax
; CHECK-NEXT:    retq
  %sh = lshr i32 %x, 31
  %r = sub i32 %y, %sh
  ret i32 %r
}

define <4 x i32> @sub_lshr_vec(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: sub_lshr_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    psrad $31, %xmm0
; CHECK-NEXT:    paddd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %sh = lshr <4 x i32> %x, <i32 31, i32 31, i32 31, i32 31>
  %r = sub <4 x i32> %y, %sh
  ret <4 x i32> %r
}

define i32 @sub_const_op_lshr(i32 %x) {
; CHECK-LABEL: sub_const_op_lshr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    sarl $31, %edi
; CHECK-NEXT:    leal 43(%rdi), %eax
; CHECK-NEXT:    retq
  %sh = lshr i32 %x, 31
  %r = sub i32 43, %sh
  ret i32 %r
}

define <4 x i32> @sub_const_op_lshr_vec(<4 x i32> %x) {
; CHECK-LABEL: sub_const_op_lshr_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    psrad $31, %xmm0
; CHECK-NEXT:    paddd {{.*}}(%rip), %xmm0
; CHECK-NEXT:    retq
  %sh = lshr <4 x i32> %x, <i32 31, i32 31, i32 31, i32 31>
  %r = sub <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %sh
  ret <4 x i32> %r
}

