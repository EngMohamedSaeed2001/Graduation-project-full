import React, {useEffect, useState} from 'react'
import {Image} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import api from "../../Apis/Base";

import {styled, useTheme} from '@mui/material/styles';
import Box from '@mui/material/Box';
import MuiDrawer from '@mui/material/Drawer';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import CssBaseline from '@mui/material/CssBaseline';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';


import ChatBody from "./ChatBody";
import ChatFooter from "./ChatFooter";
import {onValue, ref} from "firebase/database";
import {realtime} from "../../Apis/firebase";
import Load from "../../Helper/Load";

const drawerWidth = 240;

const openedMixin = (theme) => ({
  width: drawerWidth,
        height:"100%",
    maxHeight:"930px",
    borderBottomRightRadius:"30px",
     position:"absolute",
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen,
  }),
  // marginTop:'20%',
  overflowX: 'hidden',
});

const closedMixin = (theme) => ({
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  // marginTop:'20%',
    position:"absolute",
  overflowX: 'hidden',
    height:"100%",
    maxHeight:"930px",
    borderBottomRightRadius:"30px",
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up('sm')]: {
    width: `calc(${theme.spacing(15)} + 1px)`,
  },
});

const DrawerHeader = styled('div')(({ theme }) => ({
  // marginTop:'20%',
  display: 'flex',

  alignItems: 'center',
  justifyContent: 'flex-end',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
}));

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  marginTop:"200px",
  zIndex: theme.zIndex.drawer + 1,
  transition: theme.transitions.create(['width', 'margin'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const Drawer = styled(MuiDrawer, { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme, open }) => ({
    width: drawerWidth,
      height:"500px",
    flexShrink: 0,
    whiteSpace: 'nowrap',
    boxSizing: 'border-box',
    ...(open && {
      ...openedMixin(theme),
      '& .MuiDrawer-paper': openedMixin(theme),
    }),
    ...(!open && {
      ...closedMixin(theme),
      '& .MuiDrawer-paper': closedMixin(theme),
    }),
  }),
);


const ChatBar = () => {
    let {t} = useTranslation()
    let [loadUsers, setLoadUsers] = useState(false)
    let [load, setLoad] = useState(false)
    let [show, setShow] = useState(false)
    let [search, setSearch] = useState("")
    let [username, setUsername] = useState("")
    let read = false
    const [users, setUsers] = useState([])
    let [data, setData] = useState([])

   const [receiver, setReceiver] = useState("")


    let [room, setRoom] = useState(0)

      const theme = useTheme();
  const [open, setOpen] = React.useState(false);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

   const snapshotToArray = (snapshot) => {
        const returnArr = [];

        snapshot.forEach((childSnapshot) => {
            const item = childSnapshot.val();
            item.key = childSnapshot.key;
            returnArr.push(item);
        });


        return returnArr;
    }

    let fetchData = (room) => {
        const msgs = ref(realtime, `chat/${room}/`);

        onValue(msgs, (snapshot) => {
            setData([])
            setData(snapshotToArray(snapshot))

        });
        setLoad(true)

    };


    const getReceiverEmail = (id,username) => {
        setUsername(username);

        api.apiToken.get(`user/getUser/${id}`).then((res) => {
            if (res.status === 200) {

                setReceiver(res.data);

                getRooms(res.data);
            }
        }).catch((e) => {

        })
    }

    function getRooms(rec) {


        api.apiToken.get(`room-semsark/${rec}`).then((res) => {
            if (res.status === 200) {
                setRoom(res.data);
                setShow(true)
                fetchData(res.data)
            }
        }).catch((e) => {

        })
    }

     function getChats() {


        api.apiToken.get(`/chat/getChats`).then((res) => {
            if (res.status === 200) {
                setUsers(res.data)
                setLoadUsers(true)
            }
        }).catch((e) => {
            setLoadUsers(false)
        })
    }

    useEffect(() => {
        getChats()
    }, [])


    return (
     <>
       <Box className={"chat__main"} sx={{padding:"0",width:"100%", display: 'flex' }}>
      <CssBaseline />
      <AppBar position="absolute" open={open}>
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            edge="start"
            sx={{
              marginRight: 5,
              ...(open && { display: 'none' }),
            }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" noWrap component="div" style={{marginLeft:"2%",fontWeight:"bold",fontSize:"25px",fontFamily:"Helvetica"}}>
            {username===""?t("chat"):username}
          </Typography>
        </Toolbar>
      </AppBar>

      <Drawer  variant="permanent" open={open}>

        <DrawerHeader>
            <IconButton onClick={handleDrawerClose}>
            {theme.direction === 'rtl' ? <ChevronRightIcon /> : <ChevronLeftIcon />}
          </IconButton>
        </DrawerHeader>
        <Divider />
          {open ?
              <input onChange={(e)=>setSearch(e.target.value)} type={"search"} placeholder={"Search by username, etc..."}
                     style={{borderRadius: "10px", padding: "8px", margin: "10px"}}/>
              : ""
          }
          <Divider/>
        <List>
          {
            loadUsers?
              users.filter((item)=>{
                  return (item.username.toLowerCase().includes(search.toString().toLowerCase()) || item.email.toLowerCase().includes(search.toString().toLowerCase()))
              }).map((user, index) => (
            <ListItem key={index} disablePadding sx={{ display: 'block' }}  onClick={()=>getReceiverEmail(user.id,user.username)}>
              <ListItemButton
                sx={{
                  minHeight: 48,
                  justifyContent: open ? 'initial' : 'center',
                  px: 2.5,
                }}
              >
                {/*{*/}
                {/*    !read ? (*/}
                {/*            <Badge style={{position:"absolute",left:"60%",top:"10%"}} bg="danger" pill>*/}
                {/*                1*/}
                {/*            </Badge>*/}
                {/*        ) :*/}
                {/*        <></>*/}
                {/*}*/}
               <Image roundedCircle={true} src={user.image===null?"/images/avatar.png":user.image} srcSet={user.image===null?"/images/avatar.png":user.image} style={{width:'40px',height:'40px',borderRadius:"50px"}} alt={user.username}/>

                <ListItemText primary={user.username} sx={{marginLeft:'20px', opacity: open ? 1 : 0 }} />
              </ListItemButton>
            </ListItem>
          ))
                :<Load/>

          }
        </List>

      </Drawer>

      <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
        {/*<DrawerHeader />*/}

        <ChatBody show={show} load={load} data={data}/>

      </Box>


    </Box>

         {
             show?<ChatFooter receiverEmail={receiver}/>:""
         }

     </>
    )
}

export default ChatBar

