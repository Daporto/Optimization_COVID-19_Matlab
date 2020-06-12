function pak = Newton(Yo, pak, tobs, x0, h, niter)
    for k = 1:niter
        PK(:,k)=pak;
        gk= fun_dev(Yo, pak, tobs, x0, h);
        Hk= fun_dev2(Yo, pak, tobs, x0, h);
        dk= -gk/norm(gk);
        eta = line_search(0, 2, 100,Yo, pak, dk, tobs, x0);
        pak = pak+eta*dk;
        DK(:,k)= dk;
    end
end