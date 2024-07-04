import asyncio
import pytest
from fetch_data import fetch_data

@pytest.mark.asyncio
async def test_fech_data():
    result = await fetch_data()
    assert result == {'data': 'some data'}