function HVC = CalHVC(data,ref,PopNum)
    fmin   = min(data,[],1);
    data = data-fmin;
    ref = max(data,[],1)*ref;

    HVC = zeros(1,PopNum);

    for i=1:PopNum
        data1 = data;
        s = data1(i,:);
        data1(i,:)=[];
        data1 = max(s,data1);        
        HVC(1,i) = prod(ref-s)-stk_dominatedhv(data1,ref); 
        %HVC(1,i) = -stk_dominatedhv(data1,ref);        
    end
end