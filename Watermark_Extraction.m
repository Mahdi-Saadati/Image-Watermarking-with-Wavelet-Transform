function Watermark_Extraction(WatermarkingImage,watermark0,LL_R_S2,LL_G_S2,LL_B_S2,Scaling_Factor,m2,n2)
% global  watermark0 ExtractWatermark;
% global  m2 n2; 
% global  LL_R_S  LL_G_S  LL_B_S;
% global  LL_R_S2 LL_G_S2 LL_B_S2;

WatermarkingImage_R=WatermarkingImage(:,:,1);
WatermarkingImage_G=WatermarkingImage(:,:,2);
WatermarkingImage_B=WatermarkingImage(:,:,3);

[cA_R1,cH_R1,cV_R1,cD_R1]= swt2(WatermarkingImage_R,1,'db1');
[cA_G1,cH_G1,cV_G1,cD_G1]= swt2(WatermarkingImage_G,1,'db1');
[cA_B1,cH_B1,cV_B1,cD_B1]= swt2(WatermarkingImage_B,1,'db1');

[cA_R2,cH_R2,cV_R2,cD_R2]= swt2(cA_R1,1,'db1');
[cA_G2,cH_G2,cV_G2,cD_G2]= swt2(cA_G1,1,'db1');
[cA_B2,cH_B2,cV_B2,cD_B2]= swt2(cA_B1,1,'db1');

[cA_R3,cH_R3,cV_R3,cD_R3]= swt2(cA_R2,1,'db1');
[cA_G3,cH_G3,cV_G3,cD_G3]= swt2(cA_G2,1,'db1');
[cA_B3,cH_B3,cV_B3,cD_B3]= swt2(cA_B2,1,'db1');

LL_R_new=cA_R3;
LL_G_new=cA_G3;
LL_B_new=cA_B3;

[LL_R_U,LL_R_S,LL_R_V]=svd(LL_R_new);
[LL_G_U,LL_G_S,LL_G_V]=svd(LL_G_new);
[LL_B_U,LL_B_S,LL_B_V]=svd(LL_B_new);

LL_R=LL_R_U*LL_R_S*LL_R_V';
LL_G=LL_G_U*LL_G_S*LL_G_V';
LL_B=LL_B_U*LL_B_S*LL_B_V';

cA_R3=LL_R;
cA_G3=LL_G;
cA_B3=LL_B;

cA_R2=iswt2(cA_R3,cH_R3,cV_R3,cD_R3,'db1');
cA_G2=iswt2(cA_G3,cH_G3,cV_G3,cD_G3,'db1');
cA_B2=iswt2(cA_B3,cH_B3,cV_B3,cD_B3,'db1');

cA_R1=iswt2(cA_R2,cH_R2,cV_R2,cD_R2,'db1');
cA_G1=iswt2(cA_G2,cH_G2,cV_G2,cD_G2,'db1');
cA_B1=iswt2(cA_B2,cH_B2,cV_B2,cD_B2,'db1');

Extracting_Orginal_Image_R=iswt2(cA_R1,cH_R1,cV_R1,cD_R1,'db1');
Extracting_Orginal_Image_G=iswt2(cA_G1,cH_G1,cV_G1,cD_G1,'db1');
Extracting_Orginal_Image_B=iswt2(cA_B1,cH_B1,cV_B1,cD_B1,'db1');

Extracting_Orginal_Image=cat(3,Extracting_Orginal_Image_R,Extracting_Orginal_Image_G,Extracting_Orginal_Image_B);

ExtractWatermark_R=(LL_R_S2-LL_R_S)/Scaling_Factor;
ExtractWatermark_G=(LL_G_S2-LL_G_S)/Scaling_Factor;
ExtractWatermark_B=(LL_B_S2-LL_B_S)/Scaling_Factor;

ExtractWatermark=cat(3,ExtractWatermark_R,ExtractWatermark_G,ExtractWatermark_B);
ExtractWatermark=imresize(ExtractWatermark,[m2,n2]);


PSNR_value_New=PSNR(watermark0,ExtractWatermark);
SSIM_value_New=ssim(watermark0,ExtractWatermark);
NC_value =(sum(sum(sum(watermark0(:,:,:).*ExtractWatermark(:,:,:)))) / ((sqrt(sum(sum(sum(watermark0(:,:,:).^2))))).*(sqrt(sum(sum(sum(ExtractWatermark(:,:,:).^2)))))));
fprintf('%.4f \n%.4f  \n%.4f \n',PSNR_value_New,SSIM_value_New,NC_value)

end