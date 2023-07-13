import React, {useContext} from "react";
import { Navigate, Outlet } from "react-router-dom";
import {UserContext} from "../Context/UserContext";


export const ProtectedLogin = () => {
   let userToken=localStorage.getItem("user_token")
        let {expired} =useContext(UserContext)

    return (
        <>
            {(!expired && userToken) ? <Navigate
                to={{
                    pathname: "/"
                }}
            /> : <Outlet />}
        </>
    );
};