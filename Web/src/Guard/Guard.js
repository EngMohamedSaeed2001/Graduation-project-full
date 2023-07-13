import React, {useContext} from "react";
import {Navigate, Outlet} from "react-router-dom";
import {UserContext} from "../Context/UserContext";

export const ProtectedUser = () => {
let userToken=localStorage.getItem("user_token")
    let {expired} =useContext(UserContext)
    let lg = localStorage.getItem("lg")
    return (
        <>
            {(!expired && userToken)||lg
                ? <Outlet/> :

                (
                    <Navigate
                        to={{
                            pathname: "/signUp"
                        }}
                    />

                )
            }

        </>
    );
};