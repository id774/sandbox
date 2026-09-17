import tiktoken
from langchain_classic.retrievers import ParentDocumentRetriever
from langchain_core.documents import Document
from langchain_core.stores import InMemoryStore
from langchain_core.vectorstores import InMemoryVectorStore
from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter

MODEL_NAME = "text-embedding-3-small"
CHILD_CHUNK_SIZE = 200
PARENT_CHUNK_SIZE = 1000

child_splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    model_name=MODEL_NAME,
    chunk_size=CHILD_CHUNK_SIZE,
    chunk_overlap=40,
)
parent_splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    model_name=MODEL_NAME,
    chunk_size=PARENT_CHUNK_SIZE,
    chunk_overlap=100,
)

filler = (
    "契約管理の一般事項として、登録情報に変更が生じた場合は更新手続きを行います。\n"
    * 20
)

text = f"""第1節 契約種別

年間契約については、途中解約に関する以下の規定を適用します。

{filler}

第2節 途中解約

契約を途中解約した場合、未利用期間の料金は返金しません。
月間契約は次回更新日の前日までに終了手続きを行えます。
"""

documents = [Document(page_content=text)]
query = "途中解約した場合、未利用期間の料金は返金されますか"

embeddings = OpenAIEmbeddings(model=MODEL_NAME)

flat_vectorstore = InMemoryVectorStore(embeddings)
flat_documents = child_splitter.split_documents(documents)
flat_vectorstore.add_documents(flat_documents)

flat_results = flat_vectorstore.similarity_search(query, k=1)
print("=== flat retrieval ===")
print(flat_results[0].page_content)

child_vectorstore = InMemoryVectorStore(embeddings)
parent_store = InMemoryStore()

retriever = ParentDocumentRetriever(
    vectorstore=child_vectorstore,
    docstore=parent_store,
    child_splitter=child_splitter,
    parent_splitter=parent_splitter,
    search_kwargs={"k": 1},
)
retriever.add_documents(documents)

child_results = child_vectorstore.similarity_search(query, k=1)
print("=== child retrieval ===")
print(child_results[0].page_content)
print(child_results[0].metadata)

parent_results = retriever.invoke(query)
print("=== parent retrieval ===")
print(parent_results[0].page_content)

encoder = tiktoken.encoding_for_model(MODEL_NAME)


def token_count(text):
    return len(encoder.encode(text))


for child in child_results:
    print(f"child tokens: {token_count(child.page_content)}")

for parent in parent_results:
    print(f"parent tokens: {token_count(parent.page_content)}")
