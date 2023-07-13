import React, { createContext, useState, useEffect } from 'react';
import api from "../Apis/Base";

export const UserContext = createContext();

export const UserProvider = ({ children }) => {
    let [expired,setExpired]=useState(false);


  let [ads, setAds] = useState([]);
  let [favs, setFavs] = useState([]);
  let [image, setImage] = useState("https://firebasestorage.googleapis.com/v0/b/semsark-529c0.appspot.com/o/usersImages%2Favatar.png?alt=media&token=7ff7547a-06ca-4666-a4d7-134566917f3a");
    let [load, setLoad] = useState(false)
    let [username, setUsername] = useState(null);
    let [email, setEmail] = useState("");


    let [phone1, setPhone1] = useState("");

    let [gen, setGen] = useState("");

    let [user, setUser] = useState(false);


    const getMyAds=()=>{
         api.apiToken.get("user/getMyAds").then((res) => {
            if (res.status === 200) {
                setLoad(true)

                   setAds(res.data)
                }
        }).catch((e) => {

        })
    }

 const getProfile = () => {
        api.apiToken.get("user/getUser").then((res) => {
            if (res.status === 200) {
                setLoad(true)
                setEmail(res.data.email)
                setUsername(res.data.username)


                if (res.data.favourites !== null) {
                    setFavs(res.data.favourites.buildings)
                }


                if (res.data.img !== '' || res.data.img !== 'string') {
                    setImage(res.data.img)
                }

                setGen(res.data.gender)
                setPhone1(res.data.phone)

                setUser(true)

            }
        }).catch((e) => {

            if(e.response.status===401){
                localStorage.setItem("set_auth", "false");
                localStorage.setItem("user_token", "");
                // localStorage.setItem("user_email", "");
                setExpired(true)

            }

            setUser(false)

        })
    }

  useEffect(() => {
  getProfile()
      getMyAds()
  }, []);

  return (
    <UserContext.Provider value={{ads,favs,image,load,username,email,phone1,gen,user,expired}}>
      {children}
    </UserContext.Provider>
  );
};
