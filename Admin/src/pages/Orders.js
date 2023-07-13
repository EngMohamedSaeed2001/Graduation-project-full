import React, {useEffect, useState} from 'react'

import PageTitle from '../components/Typography/PageTitle'

import {
    Avatar,
    Pagination,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableFooter,
    TableHeader,
    TableRow,
} from '@windmill/react-ui'

import response from '../utils/demo/tableData'
// make a copy of the data, for the second table
const response2 = response.concat([])

function Orders() {


        // setup pages control for every table
    const [pageTable1, setPageTable1] = useState(1)
    const [pageTable2, setPageTable2] = useState(1)

    // setup data for every table
    const [dataTable1, setDataTable1] = useState([])
    const [dataTable2, setDataTable2] = useState([])

    const [verify, setVerify] = useState(false);
    const [suspend, setSuspend] = useState(false);
    const [open, setOpen] = useState(false);
    const [id, setId] = useState('0');

    const deleteUser = (id) => {
        setOpen(true);
        document.getElementById(id).style.display = "none";
    }

    // pagination setup
    const resultsPerPage = 10
    const totalResults = response.length

    // pagination change control
    function onPageChangeTable1(p) {
        setPageTable1(p)
    }

    // pagination change control
    function onPageChangeTable2(p) {
        setPageTable2(p)
    }

    // on page change, load new sliced data
    // here you would make another server request for new data

    useEffect(() => {
        setDataTable2(response2.slice((pageTable2 - 1) * resultsPerPage, pageTable2 * resultsPerPage))
    }, [pageTable2])


    return (
        <>
            <PageTitle>Orders</PageTitle>
            <TableContainer className="mb-8">
                <Table>
                    <TableHeader>
                        <tr>
                            <TableCell>Seller</TableCell>
                            <TableCell>Email</TableCell>
                            <TableCell>Phone</TableCell>
                            <TableCell>Buyer</TableCell>
                            <TableCell>Email</TableCell>
                            <TableCell>Phone</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        {dataTable2.map((user, i) => (
                            <TableRow key={i} id={user.id}>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={user.avatar ? user.avatar : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{user.name}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{user.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{user.phone}</p>
                                </TableCell>

                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={user.avatar ? user.avatar : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{user.name}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{user.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{user.phone}</p>
                                </TableCell>

                            </TableRow>
                        ))}
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

export default Orders
