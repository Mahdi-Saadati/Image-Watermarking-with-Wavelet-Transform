function Max=Maximum(A,B,C)

sum_A=sum(sum(A));
sum_B=sum(sum(B));
sum_C=sum(sum(C));

if sum_A>sum_B && sum_A>sum_C
    Max=A;

elseif sum_B>sum_A && sum_B>sum_C
    Max=B;

else
    Max=C;

end
