import React, {useEffect, useState} from 'react'

import PageTitle from '../components/Typography/PageTitle'

import {
    Avatar,
    Button,
    Pagination,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableFooter,
    TableHeader,
    TableRow,
    Input
} from '@windmill/react-ui'

import Form from 'react-bootstrap/Form';

import {TrashIcon,SearchIcon} from '../icons'

import response from '../utils/demo/tableData'
import {useTranslation} from "react-i18next";
import Api from "../utils/Base";
// make a copy of the data, for the second table
let response2 = response.concat([])


function PendingRequests() {


        // setup pages control for every table
    const [pageTable2, setPageTable2] = useState(1)

    // setup data for every table
    const [dataTable2, setDataTable2] = useState([])

    const [searcher, setSearch] = useState("");

    const [verify, setVerify] = useState(false);
    const [open, setOpen] = useState(false);
    const [id, setId] = useState('0');
    let [pend,setPend]=useState([])



    const search=(attr)=>{
        setSearch(attr.target.value)
    }

    // pagination setup
    const resultsPerPage = 10
    const totalResults = response.length



    // pagination change control
    function onPageChangeTable2(p) {
        setPageTable2(p)
    }

    // on page change, load new sliced data
    // here you would make another server request for new data

        const {t} = useTranslation()

    function allPending() {
        Api.apiToken.get("admin/getAllPendingUsers").then((res) => {
            if (res.status === 200) {
                setPend(res.data)
            }

        }).catch((e) => {

        })
    }

    useEffect(() => {
            let canc = false;
        if (!canc) {
            setTimeout(() => {

                //setData(users.slice((page - 1) * resultsPerPage, page * resultsPerPage))
                allPending()

            }, 1000)
        }
        return () => {
            canc = true;
        }
    }, [pageTable2])


    function _unVerify(email) {
        Api.apiToken.post("admin/unVerifyUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

    function _verify(email) {
        Api.apiToken.post("admin/verifyUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

    const deleteUser = (id,email) => {
        setOpen(true);
        document.getElementById(id).style.display = "none";

         Api.apiToken.delete("admin/deleteUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }




    return (
        <>
            <PageTitle>{t("PendingRequests")}</PageTitle>

            <div className="flex justify-center flex-1 lg:mr-32" style={{marginBottom:"5%"}}>
          <div className="relative w-full max-w-xl mr-6 focus-within:text-blue-500">
            <div className="absolute inset-y-0 flex items-center pl-2"  >
              <SearchIcon className="w-4 h-4" aria-hidden="true" />
            </div>
            <Input
              className="pl-8 text-gray-700"
              placeholder={t("Searchbyname,emailorphone")}
              aria-label="Search"
              value={searcher}
              onChange={(e)=>search(e)}
            />
          </div>
        </div>

            <TableContainer className="mb-8">
                <Table>
                    <TableHeader>
                        <tr>
                             <TableCell>{t("client")}</TableCell>
                            <TableCell>{t("email")}</TableCell>
                            <TableCell>{t("phone")}</TableCell>
                            <TableCell>{t("PersonalImage")}</TableCell>
                            <TableCell>{t("NationalIDImage")}</TableCell>
                            <TableCell>{t("Verify")}</TableCell>
                            <TableCell>{t("Actions")}</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        {
                            searcher!==""?
                            pend.filter((item)=>{
                return (item.name.toLowerCase().includes(searcher.toLowerCase())||item.email.toLowerCase().includes(searcher.toLowerCase())||item.phone.toLowerCase().includes(searcher.toLowerCase()))
            })
                            .map((user, i) => (
                            <TableRow key={i} id={user.id}>
                              <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={user.img ? user.img : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{user.username}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{user.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+user.phone}</p>
                                </TableCell>
                                <TableCell>
                                  <a target={"_blank"} href={user.personalImg} className={"font-semibold"}>open personal image</a>
                                </TableCell>

                                <TableCell>
                                    <a target={"_blank"} href={user.idImg} className={"font-semibold"}>open National ID image</a>
                                </TableCell>

                                <TableCell>
                                  <span className="text-sm">
                                     <Form.Check
                                         type="switch"
                                         id="custom-switch"

                                         checked={user.verifyID}

                                         onChange={() => {
                                             if(user.verifyID)
                                                 _unVerify(user.email)
                                             else
                                                 _verify(user.email)
                                         }}
                                     />
                                  </span>
                                </TableCell>

                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteUser(user.id,user.email)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                        )):
                                (
                                    pend.map((user, i) => (
                         <TableRow key={i} id={user.id}>
                              <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={user.img ? user.img : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{user.username}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{user.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+user.phone}</p>
                                </TableCell>
                                <TableCell>
                                  <a target={"_blank"} href={user.personalImg} className={"font-semibold"}>open personal image</a>
                                </TableCell>

                                <TableCell>
                                    <a target={"_blank"} href={user.idImg} className={"font-semibold"}>open National ID image</a>
                                </TableCell>

                                <TableCell>
                                  <span className="text-sm">
                                     <Form.Check
                                         type="switch"
                                         id="custom-switch"

                                         checked={user.verifyID}

                                         onChange={() => {
                                             if(user.verifyID)
                                                 _unVerify(user.email)
                                             else
                                                 _verify(user.email)
                                         }}
                                     />
                                  </span>
                                </TableCell>

                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteUser(user.id,user.email)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                                )
                                    ))
                        }
                    </TableBody>
                </Table>
                <TableFooter>
                    <Pagination
                        totalResults={totalResults}
                        resultsPerPage={resultsPerPage}
                        onChange={onPageChangeTable2}
                        label="Table navigation"
                    />
                </TableFooter>
            </TableContainer>
        </>
    )
}

export default PendingRequests
