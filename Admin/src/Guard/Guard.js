import React from "react";
import {Navigate, Outlet} from "react-router-dom";
import Auth from "../Apis/Base";

export const ProtectedUser = () => {


    return (
        <>
            {Auth.auth === 'true'
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